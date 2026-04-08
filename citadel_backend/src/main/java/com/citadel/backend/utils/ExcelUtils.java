package com.citadel.backend.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.DateUtil;
import com.citadel.backend.annotation.ExcelColumn;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Utility class for Excel operations
 */
@Slf4j
public class ExcelUtils {

    /**
     * Parse Excel sheet to a list of bean objects
     * 
     * @param sheet Excel sheet
     * @param beanClass Class of the bean object
     * @return List of bean objects
     * @param <T> Bean type
     */
    public static <T> List<T> parseExcelToBean(Sheet sheet, Class<T> beanClass) {
        List<T> beanList = new ArrayList<>();
        Row headerRow = sheet.getRow(0);
        
        // Map column positions to field names
        Map<Integer, String> columnMap = new HashMap<>();
        for (int i = 0; i < headerRow.getLastCellNum(); i++) {
            Cell cell = headerRow.getCell(i);
            if (cell != null) {
                String headerValue = cell.getStringCellValue();
                columnMap.put(i, headerValue);
            }
        }
        
        // Process data rows
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row dataRow = sheet.getRow(i);
            if (dataRow == null) {
                continue;
            }
            
            try {
                T bean = beanClass.getDeclaredConstructor().newInstance();
                // Get all fields from the bean class
                Field[] fields = beanClass.getDeclaredFields();
                Map<String, Field> fieldMap = new HashMap<>();
                for (Field field : fields) {
                    fieldMap.put(field.getName(), field);
                }
                
                // Map cell values to bean fields
                for (int j = 0; j < dataRow.getLastCellNum(); j++) {
                    Cell cell = dataRow.getCell(j);
                    if (cell == null) {
                        continue;
                    }
                    
                    String columnName = columnMap.get(j);
                    if (columnName == null) {
                        continue;
                    }
                    
                    // Find the field that corresponds to this column
                    Field field = findField(fieldMap, columnName);
                    if (field == null) {
                        continue;
                    }
                    
                    // Set the field value based on cell type
                    field.setAccessible(true);
                    setCellValueToField(cell, bean, field);
                }
                
                beanList.add(bean);
            } catch (Exception e) {
                log.error("Error parsing Excel row to bean: ", e);
            }
        }
        
        return beanList;
    }
    
    /**
     * Parse Excel sheet to a list of bean objects by column index
     * This method handles cases where there are duplicate column names in the Excel file
     * 
     * @param sheet Excel sheet
     * @param beanClass Class of the bean object
     * @param columnIndexMap Map of column indices to field names
     * @return List of bean objects
     * @param <T> Bean type
     */
    public static <T> List<T> parseExcelToBeanByColumnIndex(Sheet sheet, Class<T> beanClass, Map<Integer, String> columnIndexMap) {
        List<T> beanList = new ArrayList<>();
        
        // Process data rows
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row dataRow = sheet.getRow(i);
            if (dataRow == null) {
                continue;
            }
            
            try {
                T bean = beanClass.getDeclaredConstructor().newInstance();
                // Get all fields from the bean class
                Field[] fields = beanClass.getDeclaredFields();
                Map<String, Field> fieldMap = new HashMap<>();
                for (Field field : fields) {
                    fieldMap.put(field.getName(), field);
                }
                
                // Map cell values to bean fields based on column index
                for (Map.Entry<Integer, String> entry : columnIndexMap.entrySet()) {
                    int columnIndex = entry.getKey();
                    String fieldName = entry.getValue();
                    
                    Cell cell = dataRow.getCell(columnIndex);
                    if (cell == null) {
                        continue;
                    }
                    
                    // Find the field directly by name
                    Field field = fieldMap.get(fieldName);
                    if (field == null) {
                        // Try to find by normalized name
                        String normalizedName = fieldName.replaceAll("\\s+", "").toLowerCase();
                        for (Map.Entry<String, Field> fieldEntry : fieldMap.entrySet()) {
                            if (fieldEntry.getKey().toLowerCase().equals(normalizedName)) {
                                field = fieldEntry.getValue();
                                break;
                            }
                        }
                        
                        if (field == null) {
                            continue;
                        }
                    }
                    
                    // Set the field value based on cell type
                    field.setAccessible(true);
                    setCellValueToField(cell, bean, field);
                }
                
                beanList.add(bean);
            } catch (Exception e) {
                log.error("Error parsing Excel row to bean by column index: ", e);
            }
        }
        
        return beanList;
    }
    
    /**
     * Parse Excel sheet to a list of bean objects by column order
     * This method handles cases where there are duplicate column names in the Excel file
     * It maps Excel columns to bean fields based on the order of columns in the Excel file
     * and the order of fields with ExcelColumn annotations in the bean class
     * 
     * @param sheet Excel sheet
     * @param beanClass Class of the bean object
     * @return List of bean objects
     * @param <T> Bean type
     */
    public static <T> List<T> parseExcelToBeanByColumnOrder(Sheet sheet, Class<T> beanClass) {
        // Get all fields with ExcelColumn annotation in the order they appear in the class
        List<Field> annotatedFields = new ArrayList<>();
        for (Field field : beanClass.getDeclaredFields()) {
            if (field.isAnnotationPresent(ExcelColumn.class)) {
                annotatedFields.add(field);
            }
        }
        
        // Validate column types against field types
        validateColumnTypes(sheet, annotatedFields);
        
        List<T> beanList = new ArrayList<>();
        
        // Process data rows
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row dataRow = sheet.getRow(i);
            if (dataRow == null) {
                continue;
            }
            
            try {
                T bean = beanClass.getDeclaredConstructor().newInstance();
                
                // Map cell values to bean fields based on column order
                for (int j = 0; j < Math.min(dataRow.getLastCellNum(), annotatedFields.size()); j++) {
                    Cell cell = dataRow.getCell(j);
                    if (cell == null) {
                        continue;
                    }
                    
                    Field field = annotatedFields.get(j);
                    field.setAccessible(true);
                    
                    try {
                        setCellValueToField(cell, bean, field);
                    } catch (Exception e) {
                        log.warn("Error setting field '{}' from cell at row: {}, column: {}: {}", 
                                field.getName(), i, j, e.getMessage());
                    }
                }
                
                beanList.add(bean);
            } catch (Exception e) {
                log.error("Error parsing Excel row {} to bean: {}", i, e.getMessage());
            }
        }
        
        return beanList;
    }
    
    /**
     * Validate column types against field types
     * This method checks if the column types in the Excel sheet are compatible with the field types in the bean class
     * 
     * @param sheet Excel sheet
     * @param annotatedFields List of fields with ExcelColumn annotation
     */
    private static void validateColumnTypes(Sheet sheet, List<Field> annotatedFields) {
        if (sheet.getLastRowNum() < 1) {
            return; // No data rows to validate
        }
        
        Row headerRow = sheet.getRow(0);
        Row firstDataRow = sheet.getRow(1);
        
        if (firstDataRow == null) {
            return; // No data row to validate
        }
        
        for (int i = 0; i < Math.min(firstDataRow.getLastCellNum(), annotatedFields.size()); i++) {
            Cell cell = firstDataRow.getCell(i);
            if (cell == null) {
                continue;
            }
            
            Field field = annotatedFields.get(i);
            Class<?> fieldType = field.getType();
            
            // Check for potential type mismatches
            if (cell.getCellType() == CellType.STRING) {
                if (fieldType == Double.class || fieldType == double.class || 
                    fieldType == Integer.class || fieldType == int.class || 
                    fieldType == Long.class || fieldType == long.class) {
                    
                    String headerName = "";
                    Cell headerCell = headerRow.getCell(i);
                    if (headerCell != null) {
                        headerName = headerCell.getStringCellValue();
                    }
                    
                    log.warn("Potential type mismatch: Column '{}' (index {}) contains string value '{}' but field '{}' is of type {}",
                            headerName, i, cell.getStringCellValue(), field.getName(), fieldType.getSimpleName());
                }
            } else if (cell.getCellType() == CellType.NUMERIC && !DateUtil.isCellDateFormatted(cell)) {
                if (fieldType == String.class) {
                    String headerName = "";
                    Cell headerCell = headerRow.getCell(i);
                    if (headerCell != null) {
                        headerName = headerCell.getStringCellValue();
                    }
                    
                    log.info("Note: Column '{}' (index {}) contains numeric value {} which will be converted to String for field '{}'",
                            headerName, i, cell.getNumericCellValue(), field.getName());
                }
            }
        }
    }
    
    /**
     * Parse Excel sheet to a list of bean objects by position
     * This method handles cases where there are duplicate column names in the Excel file
     * It uses the position of fields in the bean class to determine the mapping
     * 
     * @param sheet Excel sheet
     * @param beanClass Class of the bean object
     * @param columnPositionMap Map of column positions to field positions (optional)
     * @return List of bean objects
     * @param <T> Bean type
     */
    public static <T> List<T> parseExcelToBeanByPosition(Sheet sheet, Class<T> beanClass, Map<Integer, Integer> columnPositionMap) {
        List<T> beanList = new ArrayList<>();
        Row headerRow = sheet.getRow(0);
        
        // Get all fields with ExcelColumn annotation
        Field[] fields = beanClass.getDeclaredFields();
        List<Field> annotatedFields = new ArrayList<>();
        for (Field field : fields) {
            if (field.isAnnotationPresent(ExcelColumn.class)) {
                annotatedFields.add(field);
            }
        }
        
        // If columnPositionMap is not provided, create a default mapping
        Map<Integer, Integer> positionMap = columnPositionMap;
        if (positionMap == null) {
            positionMap = new HashMap<>();
            for (int i = 0; i < Math.min(headerRow.getLastCellNum(), annotatedFields.size()); i++) {
                positionMap.put(i, i);
            }
        }
        
        // Process data rows
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row dataRow = sheet.getRow(i);
            if (dataRow == null) {
                continue;
            }
            
            try {
                T bean = beanClass.getDeclaredConstructor().newInstance();
                
                // Map cell values to bean fields based on position
                for (Map.Entry<Integer, Integer> entry : positionMap.entrySet()) {
                    int excelColumnIndex = entry.getKey();
                    int fieldIndex = entry.getValue();
                    
                    if (fieldIndex >= annotatedFields.size()) {
                        continue;
                    }
                    
                    Cell cell = dataRow.getCell(excelColumnIndex);
                    if (cell == null) {
                        continue;
                    }
                    
                    Field field = annotatedFields.get(fieldIndex);
                    field.setAccessible(true);
                    setCellValueToField(cell, bean, field);
                }
                
                beanList.add(bean);
            } catch (Exception e) {
                log.error("Error parsing Excel row to bean by position: ", e);
            }
        }
        
        return beanList;
    }
    
    /**
     * Create a column index map from bean class using ExcelColumn annotations
     * This method creates a mapping from column indices to field names based on the order of fields in the bean class
     * 
     * @param beanClass Class of the bean object
     * @return Map of column indices to field names
     */
    public static Map<Integer, String> createColumnIndexMapFromBean(Class<?> beanClass) {
        Map<Integer, String> columnIndexMap = new HashMap<>();
        Field[] fields = beanClass.getDeclaredFields();
        
        int index = 0;
        for (Field field : fields) {
            ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class);
            if (excelColumn != null) {
                columnIndexMap.put(index++, field.getName());
            }
        }
        
        return columnIndexMap;
    }
    
    /**
     * Create a column index map from Excel header row and bean class
     * This method creates a mapping from column indices to field names based on the Excel header row
     * and the ExcelColumn annotations in the bean class
     * 
     * @param headerRow Excel header row
     * @param beanClass Class of the bean object
     * @return Map of column indices to field names
     */
    public static Map<Integer, String> createColumnIndexMapFromHeaderRow(Row headerRow, Class<?> beanClass) {
        Map<Integer, String> columnIndexMap = new HashMap<>();
        Map<String, Field> annotatedFields = new HashMap<>();
        
        // Create a map of ExcelColumn annotation values to fields
        for (Field field : beanClass.getDeclaredFields()) {
            ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class);
            if (excelColumn != null) {
                annotatedFields.put(excelColumn.value(), field);
            }
        }
        
        // Map column indices to field names based on header row
        for (int i = 0; i < headerRow.getLastCellNum(); i++) {
            Cell cell = headerRow.getCell(i);
            if (cell != null) {
                String headerValue = cell.getStringCellValue();
                Field field = annotatedFields.get(headerValue);
                if (field != null) {
                    columnIndexMap.put(i, field.getName());
                }
            }
        }
        
        return columnIndexMap;
    }
    
    /**
     * Find a field in the field map that matches the column name
     * 
     * @param fieldMap Map of field names to fields
     * @param columnName Column name to match
     * @return Matching field or null if not found
     */
    private static Field findField(Map<String, Field> fieldMap, String columnName) {
        // First try to find a field with matching ExcelColumn annotation
        for (Map.Entry<String, Field> entry : fieldMap.entrySet()) {
            Field field = entry.getValue();
            ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class);
            if (excelColumn != null && columnName.equals(excelColumn.value())) {
                return field;
            }
        }
        
        // If no match by annotation, try direct match
        Field field = fieldMap.get(columnName);
        if (field != null) {
            return field;
        }
        
        // Try normalized name match (remove spaces, lowercase)
        String normalizedName = columnName.replaceAll("\\s+", "").toLowerCase();
        for (Map.Entry<String, Field> entry : fieldMap.entrySet()) {
            String fieldName = entry.getKey().toLowerCase();
            if (fieldName.equals(normalizedName)) {
                return entry.getValue();
            }
        }
        
        return null;
    }
    
    /**
     * Set cell value to a field based on cell type
     * 
     * @param cell Excel cell
     * @param bean Bean object
     * @param field Field to set
     * @param <T> Bean type
     * @throws IllegalAccessException If field is inaccessible
     */
    private static <T> void setCellValueToField(Cell cell, T bean, Field field) throws IllegalAccessException {
        Class<?> fieldType = field.getType();
        
        try {
            switch (cell.getCellType()) {
                case STRING:
                    String stringValue = cell.getStringCellValue();
                    if (fieldType == String.class) {
                        field.set(bean, stringValue);
                    } else if (fieldType == Integer.class || fieldType == int.class) {
                        try {
                            field.set(bean, Integer.parseInt(stringValue));
                        } catch (NumberFormatException e) {
                            log.warn("Cannot convert string '{}' to Integer for field '{}'. Setting to null/default.", 
                                    stringValue, field.getName());
                        }
                    } else if (fieldType == Double.class || fieldType == double.class) {
                        try {
                            field.set(bean, Double.parseDouble(stringValue));
                        } catch (NumberFormatException e) {
                            log.warn("Cannot convert string '{}' to Double for field '{}'. Setting to null/default.", 
                                    stringValue, field.getName());
                        }
                    } else if (fieldType == Boolean.class || fieldType == boolean.class) {
                        field.set(bean, Boolean.parseBoolean(stringValue));
                    }
                    break;
                    
                case NUMERIC:
                    if (DateUtil.isCellDateFormatted(cell)) {
                        if (fieldType == java.util.Date.class) {
                            field.set(bean, cell.getDateCellValue());
                        } else if (fieldType == java.time.LocalDate.class) {
                            field.set(bean, cell.getLocalDateTimeCellValue().toLocalDate());
                        }
                    } else {
                        double numericValue = cell.getNumericCellValue();
                        if (fieldType == Double.class || fieldType == double.class) {
                            field.set(bean, numericValue);
                        } else if (fieldType == Integer.class || fieldType == int.class) {
                            field.set(bean, (int) numericValue);
                        } else if (fieldType == Long.class || fieldType == long.class) {
                            field.set(bean, (long) numericValue);
                        } else if (fieldType == String.class) {
                            // If it's a large number, store it as a string to avoid scientific notation
                            field.set(bean, String.valueOf((long) numericValue));
                        }
                    }
                    break;
                    
                case BOOLEAN:
                    boolean boolValue = cell.getBooleanCellValue();
                    if (fieldType == Boolean.class || fieldType == boolean.class) {
                        field.set(bean, boolValue);
                    } else if (fieldType == String.class) {
                        field.set(bean, String.valueOf(boolValue));
                    }
                    break;
                    
                case BLANK:
                    // Leave the field as its default value
                    break;
                    
                case ERROR:
                    log.warn("Error cell value at row: {}, column: {}", cell.getRowIndex(), cell.getColumnIndex());
                    break;
                    
                default:
                    log.warn("Unsupported cell type: {} at row: {}, column: {}", 
                            cell.getCellType(), cell.getRowIndex(), cell.getColumnIndex());
            }
        } catch (Exception e) {
            log.warn("Error setting field '{}' from cell at row: {}, column: {}: {}", 
                    field.getName(), cell.getRowIndex(), cell.getColumnIndex(), e.getMessage());
        }
    }
    
    /**
     * Parse Excel sheet to a list of bean objects, handling duplicate column names
     * This method is specifically designed for Excel files that may contain duplicate column names
     * It uses a custom mapping strategy where you provide a map of column indices to field names
     * 
     * @param sheet Excel sheet
     * @param beanClass Class of the bean object
     * @param columnMappings Map of column indices to field names
     * @return List of bean objects
     * @param <T> Bean type
     */
    public static <T> List<T> parseExcelToBeanWithDuplicateColumns(Sheet sheet, Class<T> beanClass, Map<Integer, String> columnMappings) {
        List<T> beanList = new ArrayList<>();
        
        // Log the column mappings for debugging
        if (log.isDebugEnabled()) {
            Row headerRow = sheet.getRow(0);
            if (headerRow != null) {
                for (Map.Entry<Integer, String> entry : columnMappings.entrySet()) {
                    int columnIndex = entry.getKey();
                    String fieldName = entry.getValue();
                    Cell headerCell = headerRow.getCell(columnIndex);
                    String headerName = headerCell != null ? headerCell.getStringCellValue() : "N/A";
                    log.debug("Mapping column {} ('{}') to field '{}'", columnIndex, headerName, fieldName);
                }
            }
        }
        
        // Process data rows
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row dataRow = sheet.getRow(i);
            if (dataRow == null) {
                continue;
            }
            
            try {
                T bean = beanClass.getDeclaredConstructor().newInstance();
                
                // Get all fields from the bean class
                Field[] fields = beanClass.getDeclaredFields();
                Map<String, Field> fieldMap = new HashMap<>();
                for (Field field : fields) {
                    fieldMap.put(field.getName(), field);
                }
                
                // Process each column mapping
                for (Map.Entry<Integer, String> entry : columnMappings.entrySet()) {
                    int columnIndex = entry.getKey();
                    String fieldName = entry.getValue();
                    
                    Cell cell = dataRow.getCell(columnIndex);
                    if (cell == null) {
                        continue;
                    }
                    
                    // Find the field by name
                    Field field = fieldMap.get(fieldName);
                    if (field == null) {
                        log.warn("Field '{}' not found in class {}", fieldName, beanClass.getName());
                        continue;
                    }
                    
                    // Set the field value
                    field.setAccessible(true);
                    try {
                        setCellValueToField(cell, bean, field);
                    } catch (Exception e) {
                        log.warn("Error setting field '{}' from cell at row: {}, column: {}: {}", 
                                fieldName, i, columnIndex, e.getMessage());
                    }
                }
                
                beanList.add(bean);
            } catch (Exception e) {
                log.error("Error parsing Excel row {} to bean: {}", i, e.getMessage());
            }
        }
        
        return beanList;
    }
    
    /**
     * Create a column mapping for Excel files with duplicate column names
     * This method creates a mapping from column indices to field names based on the Excel header row
     * and a custom mapping strategy for handling duplicate column names
     * 
     * @param headerRow Excel header row
     * @param duplicateColumnMappings Map of duplicate column names to field names
     * @return Map of column indices to field names
     */
    public static Map<Integer, String> createMappingForDuplicateColumns(Row headerRow, Map<String, List<String>> duplicateColumnMappings) {
        Map<Integer, String> columnMappings = new HashMap<>();
        
        // Track occurrences of each column name
        Map<String, Integer> columnOccurrences = new HashMap<>();
        
        // Process each cell in the header row
        for (int i = 0; i < headerRow.getLastCellNum(); i++) {
            Cell cell = headerRow.getCell(i);
            if (cell == null) {
                continue;
            }
            
            String columnName = cell.getStringCellValue();
            
            // Skip empty column names
            if (columnName == null || columnName.trim().isEmpty()) {
                continue;
            }
            
            // Check if this is a duplicate column
            if (duplicateColumnMappings.containsKey(columnName)) {
                // Get the occurrence index (0-based)
                int occurrenceIndex = columnOccurrences.getOrDefault(columnName, 0);
                
                // Get the list of field names for this column
                List<String> fieldNames = duplicateColumnMappings.get(columnName);
                
                // If we have a field name for this occurrence, add it to the mapping
                if (occurrenceIndex < fieldNames.size()) {
                    String fieldName = fieldNames.get(occurrenceIndex);
                    columnMappings.put(i, fieldName);
                    log.debug("Mapping duplicate column '{}' (occurrence {}) to field '{}'", 
                            columnName, occurrenceIndex, fieldName);
                } else {
                    log.warn("No field mapping found for column '{}' occurrence {}", 
                            columnName, occurrenceIndex);
                }
                
                // Increment the occurrence counter
                columnOccurrences.put(columnName, occurrenceIndex + 1);
            } else {
                // For non-duplicate columns, just add them to the mapping with the column name as the field name
                // This assumes that the field name matches the column name
                columnMappings.put(i, columnName);
            }
        }
        
        return columnMappings;
    }
} 