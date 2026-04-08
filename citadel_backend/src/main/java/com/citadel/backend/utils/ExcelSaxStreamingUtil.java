package com.citadel.backend.utils;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xssf.eventusermodel.ReadOnlySharedStringsTable;
import org.apache.poi.xssf.eventusermodel.XSSFReader;
import org.apache.poi.xssf.model.StylesTable;
import org.apache.poi.xssf.usermodel.XSSFComment;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class ExcelSaxStreamingUtil {

    //Usage Example
//    ExcelSaxStreamingUtil.processExcelFile("your.xlsx", 0, (row, rowNum) -> {
//        // row is List<String> for each row, rowNum is the row index
//        System.out.println(row);
//    });


    public interface RowHandler {
        void handleRow(List<String> rowValues, int rowNum);
    }

    public static void processExcelFile(String excelFilePath, int sheetIndex, RowHandler rowHandler) throws Exception {
        try (OPCPackage pkg = OPCPackage.open(excelFilePath)) {
            XSSFReader reader = new XSSFReader(pkg);
            StylesTable styles = reader.getStylesTable();
            ReadOnlySharedStringsTable strings = new ReadOnlySharedStringsTable(pkg);

            int currentSheet = 0;
            XSSFReader.SheetIterator iter = (XSSFReader.SheetIterator) reader.getSheetsData();
            while (iter.hasNext()) {
                try (InputStream stream = iter.next()) {
                    if (currentSheet == sheetIndex) {
                        processSheet(styles, strings, rowHandler, stream);
                        break;
                    }
                    currentSheet++;
                }
            }
        }
    }

    private static void processSheet(StylesTable styles, ReadOnlySharedStringsTable strings, RowHandler rowHandler, InputStream sheetInputStream) throws Exception {
        XMLReader parser = org.xml.sax.helpers.XMLReaderFactory.createXMLReader();
        SheetHandler handler = new SheetHandler(rowHandler, strings);
        parser.setContentHandler(handler);
        parser.parse(new InputSource(sheetInputStream));
    }

    private static class SheetHandler extends DefaultHandler {
        private final RowHandler rowHandler;
        private final ReadOnlySharedStringsTable strings;
        private List<String> rowValues = new ArrayList<>();
        private StringBuilder value = new StringBuilder();
        private boolean isValue;
        private int rowNum = 0;

        public SheetHandler(RowHandler rowHandler, ReadOnlySharedStringsTable strings) {
            this.rowHandler = rowHandler;
            this.strings = strings;
        }

        @Override
        public void startElement(String uri, String localName, String qName, Attributes attributes) {
            if ("row".equals(qName)) {
                rowValues = new ArrayList<>();
            } else if ("c".equals(qName)) {
                isValue = true;
            }
        }

        @Override
        public void endElement(String uri, String localName, String qName) {
            if ("v".equals(qName) && isValue) {
                rowValues.add(value.toString());
                value.setLength(0);
                isValue = false;
            } else if ("row".equals(qName)) {
                rowHandler.handleRow(rowValues, rowNum++);
            }
        }

        @Override
        public void characters(char[] ch, int start, int length) {
            if (isValue) {
                value.append(ch, start, length);
            }
        }
    }
}