package com.citadel.backend.utils;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;

public class LocalDateToMillisecondSerializer extends JsonSerializer<LocalDate> {
    @Override
    public void serialize(LocalDate localDate, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        if (localDate != null) {
            long epochMilli = localDate.atStartOfDay(ZoneId.systemDefault()).toInstant().toEpochMilli();
            jsonGenerator.writeNumber(epochMilli);
        } else {
            jsonGenerator.writeNull();
        }
    }
}
