package com.citadel.backend.utils;

import com.citadel.backend.service.ExcelService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.util.*;

@Service
public class ExcelStreamingUtil {
    private static final Logger log = LoggerFactory.getLogger(ExcelStreamingUtil.class);

    public enum ParseStrategy {
        COLUMN_NAME, COLUMN_ORDER
    }

    public <T> List<T> processExcelFile(String excelFilePath, int sheetIndex, Class<T> clazz, ParseStrategy strategy) {
        try (InputStream fis = new FileInputStream(excelFilePath);
             Workbook workbook = new XSSFWorkbook(fis)) {

            log.info("Successfully opened Excel workbook for streaming from path: {}", excelFilePath);

            if (sheetIndex < 0 || sheetIndex >= workbook.getNumberOfSheets()) {
                log.error("Invalid sheet index: {} for workbook with {} sheets.", sheetIndex, workbook.getNumberOfSheets());
                return new ArrayList<>();
            }

            Sheet sheet = workbook.getSheetAt(sheetIndex);
            if (sheet == null) {
                log.error("Sheet at index {} not found.", sheetIndex);
                return new ArrayList<>();
            }
            log.info("Streaming sheet: {}", sheet.getSheetName());

            return parseSheetFromStreamToVoClass(sheet, clazz, strategy);

        } catch (IOException e) {
            log.error("IOException while processing Excel file: {}", excelFilePath, e);
            return new ArrayList<>();
        } catch (Exception e) {
            log.error("Unexpected error while processing Excel file: {}", excelFilePath, e);
            return new ArrayList<>();
        }
    }

    private <T> List<T> parseSheetFromStreamToVoClass(Sheet sheet, Class<T> beanClass, ParseStrategy strategy) {

        // Parse Excel rows into a list of objects of type T
        List<T> records = new ArrayList<>();
        if (ParseStrategy.COLUMN_NAME.equals(strategy)) {
            records = ExcelUtils.parseExcelToBean(sheet, beanClass);
        }
        if (ParseStrategy.COLUMN_ORDER.equals(strategy)) {
            records = ExcelUtils.parseExcelToBeanByColumnOrder(sheet, beanClass);
        }

        log.info("Successfully parsed {} records from Excel sheet for class {}", records.size(), beanClass.getSimpleName());
        return records;
    }

    /**
     * Finds a field in the provided map of field names to Field objects.
     * This implementation attempts a case-insensitive match if a direct match fails.
     * For more advanced scenarios, consider using annotations on fields to specify Excel column names.
     *
     * @param fieldNameToFieldMap A map of field names (as declared in the Java class) to Field objects.
     * @param excelColumnHeaderName The header name from the Excel column.
     * @return The matching Field object, or null if not found.
     */
    private Field findFieldByHeaderName(Map<String, Field> fieldNameToFieldMap, String excelColumnHeaderName) {
        if (excelColumnHeaderName == null || excelColumnHeaderName.trim().isEmpty()) {
            return null;
        }
        String normalizedHeaderName = excelColumnHeaderName.replaceAll("\\s+", "").toLowerCase(); // Example normalization

        // Attempt direct match (case-sensitive, based on original field names in map)
        // If your fieldMap keys are already normalized, this part might change.
        // For this example, assume fieldMap keys are original field names.

        // More robust: iterate through fieldMap and compare normalized names
        for (Map.Entry<String, Field> entry : fieldNameToFieldMap.entrySet()) {
            String beanFieldName = entry.getKey();
            // Option 1: Direct match (case sensitive) if headers match field names exactly
            // if (beanFieldName.equals(excelColumnHeaderName)) return entry.getValue();

            // Option 2: Case-insensitive match
            // if (beanFieldName.equalsIgnoreCase(excelColumnHeaderName)) return entry.getValue();

            // Option 3: Normalized match (e.g., remove spaces, toLowerCase)
            String normalizedBeanFieldName = beanFieldName.replaceAll("\\s+", "").toLowerCase();
            if (normalizedBeanFieldName.equals(normalizedHeaderName)) {
                return entry.getValue();
            }

            // Option 4: Check for an annotation on the field (e.g., @ExcelCellName("Actual Excel Header"))
            // This is the most flexible approach but requires defining the annotation.
            // Example (conceptual):
            // ExcelCellName annotation = entry.getValue().getAnnotation(ExcelCellName.class);
            // if (annotation != null && annotation.value().equalsIgnoreCase(excelColumnHeaderName)) {
            //    return entry.getValue();
            // }
        }
        // Fallback: if no sophisticated matching, try a simple case-insensitive match on the original header
        for (Map.Entry<String, Field> entry : fieldNameToFieldMap.entrySet()) {
            if (entry.getKey().equalsIgnoreCase(excelColumnHeaderName)) return entry.getValue();
        }


        log.trace("No field found for header '{}' after attempting various matches.", excelColumnHeaderName);
        return null; // Or throw an exception if strict mapping is required
    }

    /**
     * Sets the value of a cell to a field in the bean.
     * Includes basic type conversion.
     */
    private void setCellValueToField(Cell cell, Object bean, Field field) throws IllegalAccessException {
        DataFormatter dataFormatter = new DataFormatter();
        String cellValue = (cell == null || cell.getCellType() == CellType.BLANK) ? null : dataFormatter.formatCellValue(cell).trim();
        Class<?> fieldType = field.getType();

        if (cellValue == null || cellValue.isEmpty()) {
            if (!fieldType.isPrimitive()) {
                field.set(bean, null);
            }
            return;
        }

        try {
            if (fieldType.equals(String.class)) {
                field.set(bean, cellValue);
            } else if (fieldType.equals(Double.class) || fieldType.equals(double.class)) {
                try {
                    field.set(bean, Double.parseDouble(cellValue));
                } catch (NumberFormatException e) {
                    log.warn("Could not parse string '{}' to Double for field {}", cellValue, field.getName());
                    field.set(bean, fieldType.isPrimitive() ? 0.0 : null);
                }
            } else if (fieldType.equals(Integer.class) || fieldType.equals(int.class)) {
                try {
                    field.set(bean, Integer.parseInt(cellValue));
                } catch (NumberFormatException e) {
                    log.warn("Could not parse string '{}' to Integer for field {}", cellValue, field.getName());
                    field.set(bean, fieldType.isPrimitive() ? 0 : null);
                }
            } else if (fieldType.equals(Long.class) || fieldType.equals(long.class)) {
                try {
                    field.set(bean, Long.parseLong(cellValue));
                } catch (NumberFormatException e) {
                    log.warn("Could not parse string '{}' to Long for field {}", cellValue, field.getName());
                    field.set(bean, fieldType.isPrimitive() ? 0L : null);
                }
            } else if (fieldType.equals(java.util.Date.class)) {
                // You may want to implement a date parser here if needed
                log.warn("String to Date conversion for field {} not fully implemented. Received string: {}", field.getName(), cellValue);
                field.set(bean, null);
            } else if (fieldType.equals(Boolean.class) || fieldType.equals(boolean.class)) {
                String val = cellValue.toLowerCase();
                if ("true".equals(val) || "yes".equals(val) || "1".equals(val)) {
                    field.set(bean, true);
                } else if ("false".equals(val) || "no".equals(val) || "0".equals(val)) {
                    field.set(bean, false);
                } else {
                    log.warn("Could not parse string '{}' to Boolean for field {}", val, field.getName());
                    field.set(bean, fieldType.isPrimitive() ? false : null);
                }
            }
        } catch (IllegalStateException e) {
            log.warn("IllegalStateException for field {}: {}. CellType: {}, Row: {}, Col: {}", field.getName(), e.getMessage(), cell != null ? cell.getCellType() : null, cell != null ? cell.getRowIndex() : null, cell != null ? cell.getColumnIndex() : null);
            if (!fieldType.isPrimitive()) field.set(bean, null);
        }
    }

    // Example of how you might call this service:
    // public static void main(String[] args) {
    //     ExcelProcessingService service = new ExcelProcessingService();
    //     // Assuming YourBeanClass is the class you want to map to.
    //     // Make sure YourBeanClass has a public no-argument constructor and fields
    //     // that match (case-insensitively or via annotations) your Excel headers.
    //     List<YourBeanClass> result = service.processExcelFile(
    //         "/path/to/your/excel.xlsx",
    //         0, // sheet index
    //         YourBeanClass.class,
    //         ParseStrategy.COLUMN_NAME);
    //
    //     result.forEach(bean -> System.out.println(bean)); // Replace with your logic
    // }
}
