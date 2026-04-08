package com.citadel.backend.utils;

import com.citadel.backend.annotation.ExcelColumn;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xssf.eventusermodel.ReadOnlySharedStringsTable;
import org.apache.poi.xssf.eventusermodel.XSSFReader;
import org.apache.poi.xssf.model.StylesTable;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;

import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.*;

public class ExcelSaxBeanMapper {
    private static final Logger log = LoggerFactory.getLogger(ExcelSaxBeanMapper.class);

    //Usage Example
    //List<MyBean> beans = ExcelSaxBeanMapper.processExcelFile("your.xlsx", 0, MyBean.class);
    public static <T> List<T> processExcelFile(String excelFilePath, int sheetIndex, Class<T> clazz) throws Exception {
        List<T> result = new ArrayList<>();
        try (OPCPackage pkg = OPCPackage.open(excelFilePath)) {
            XSSFReader reader = new XSSFReader(pkg);
            ReadOnlySharedStringsTable strings = new ReadOnlySharedStringsTable(pkg);

            int currentSheet = 0;
            XSSFReader.SheetIterator iter = (XSSFReader.SheetIterator) reader.getSheetsData();
            while (iter.hasNext()) {
                try (InputStream stream = iter.next()) {
                    if (currentSheet == sheetIndex) {
                        processSheet(strings, stream, clazz, result);
                        break;
                    }
                    currentSheet++;
                }
            }
        }
        return result;
    }

    private static <T> void processSheet(ReadOnlySharedStringsTable strings, InputStream sheetInputStream, Class<T> clazz, List<T> result) throws Exception {
        XMLReader parser = org.xml.sax.helpers.XMLReaderFactory.createXMLReader();
        StylesTable styles = null;  // We'll not use styles for now, but could be added if needed
        SheetHandler<T> handler = new SheetHandler<>(strings, styles, clazz, result);
        parser.setContentHandler(handler);
        parser.parse(new InputSource(sheetInputStream));
    }

    private static class SheetHandler<T> extends DefaultHandler {
        private final ReadOnlySharedStringsTable strings;
        private final StylesTable styles;
        private final Class<T> clazz;
        private final List<T> result;
        private final Map<String, Field> fieldMap = new HashMap<>();
        private List<String> headerNames = new ArrayList<>();
        private List<String> cellValues = new ArrayList<>();
        private boolean isHeaderRow = true;
        private boolean isValue;
        private String cellType;
        private StringBuilder value = new StringBuilder();
        private int currentCol = -1;
        private int lastCol = -1;

        public SheetHandler(ReadOnlySharedStringsTable strings, StylesTable styles, Class<T> clazz, List<T> result) {
            this.strings = strings;
            this.styles = styles;
            this.clazz = clazz;
            this.result = result;
            for (Field field : clazz.getDeclaredFields()) {
                field.setAccessible(true);
                ExcelColumn annotation = field.getAnnotation(ExcelColumn.class);
                if (annotation != null) {
                    // Use the annotation value for mapping
                    fieldMap.put(normalize(annotation.value()), field);
                    log.debug("Mapped column '{}' to field '{}'", annotation.value(), field.getName());
                } else {
                    // Fallback to field name if annotation is not present
                    fieldMap.put(normalize(field.getName()), field);
                    log.debug("Mapped column '{}' to field '{}'", field.getName(), field.getName());
                }
            }
        }

        @Override
        public void startElement(String uri, String localName, String qName, Attributes attributes) {
            if ("row".equals(qName)) {
                cellValues = new ArrayList<>();
                currentCol = -1;
                lastCol = -1;
            } else if ("c".equals(qName)) {
                isValue = false; // Reset to false - we'll set to true when we see "v" element
                cellType = attributes.getValue("t");
                String r = attributes.getValue("r");
                currentCol = getColIndex(r);
                // Fill missing columns with empty string
                for (int i = lastCol + 1; i < currentCol; i++) {
                    cellValues.add("");
                }
                lastCol = currentCol;
            } else if ("v".equals(qName) || "t".equals(qName)) {
                // Value element or inline text
                isValue = true;
                value.setLength(0); // Clear the value buffer
            }
        }

        @Override
        public void endElement(String uri, String localName, String qName) {
            if (("v".equals(qName) || "t".equals(qName)) && isValue) {
                String cellVal = getCellValue(value.toString(), cellType);
                log.debug("Read cell value: {}", cellVal);
                cellValues.add(cellVal);
                value.setLength(0);
                isValue = false;
            }
            else if ("c".equals(qName) && cellValues.size() <= currentCol) {
                // Empty cell
                cellValues.add("");
                value.setLength(0);
            }
            else if ("row".equals(qName)) {
                // Fill trailing empty columns
                for (int i = cellValues.size(); i < headerNames.size(); i++) {
                    cellValues.add("");
                }

                if (isHeaderRow) {
                    headerNames = new ArrayList<>(cellValues);
                    isHeaderRow = false;
                }
                else {
                    try {
                        T bean = clazz.getDeclaredConstructor().newInstance();
                        for (int i = 0; i < headerNames.size() && i < cellValues.size(); i++) {
                            String header = normalize(headerNames.get(i));
                            Field field = fieldMap.get(header);
                            if (field != null) {
                                setFieldValue(field, bean, cellValues.get(i));
                            }
                        }
                        result.add(bean);
                    } catch (Exception e) {
                        log.warn("Failed to map row to bean: {}", e.getMessage(), e);
                    }
                }
            }
        }

        @Override
        public void characters(char[] ch, int start, int length) {
            if (isValue) {
                value.append(ch, start, length);
            }
        }

        private String getCellValue(String val, String cellType) {
            if (val == null || val.isEmpty()) {
                return "";
            }

            try {
                if ("s".equals(cellType)) {
                    // Shared string
                    int idx = Integer.parseInt(val);
                    return strings.getItemAt(idx).toString();
                } else if ("b".equals(cellType)) {
                    // Boolean
                    return "1".equals(val) ? "true" : "false";
                } else if ("e".equals(cellType)) {
                    // Error
                    return "ERROR:" + val;
                } else if ("str".equals(cellType)) {
                    // Formula string
                    return val;
                } else if ("inlineStr".equals(cellType)) {
                    // Inline string
                    return val;
                } else {
                    // Numeric (default type when cellType is null or "n") or any other type
                    // Always return as string, even for numbers with special formatting
                    return val;
                }
            } catch (Exception e) {
                log.warn("Error processing cell value: {}", e.getMessage());
                return val; // Return the original value if there's any error
            }
        }

        private int getColIndex(String cellRef) {
            if (cellRef == null) return lastCol + 1;
            int col = 0;
            for (int i = 0; i < cellRef.length(); i++) {
                char ch = cellRef.charAt(i);
                if (Character.isLetter(ch)) {
                    col = col * 26 + (ch - 'A' + 1);
                } else {
                    break;
                }
            }
            return col - 1;
        }

        private String normalize(String s) {
            return s == null ? "" : s.replaceAll("\\s+", "").toLowerCase();
        }

        private void setFieldValue(Field field, Object bean, String value) throws IllegalAccessException {
            try {
                if (value == null || value.trim().isEmpty()) {
                    field.set(bean, null);
                } else {
                    field.set(bean, value.trim());
                }
                log.debug("Set field {} to '{}'", field.getName(), value);
            } catch (Exception e) {
                log.warn("Failed to set field {}: {}", field.getName(), e.getMessage());
                // Still try to set it as a string, even if there was an error
                field.set(bean, value != null ? value.trim() : null);
            }
        }
    }
}
