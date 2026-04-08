package com.citadel.backend.utils;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneOffset;

public class LocalDateTypeAdapter extends TypeAdapter<LocalDate> {
    @Override
    public void write(JsonWriter out, LocalDate value) throws IOException {
        if (value == null) {
            out.nullValue();
        } else {
            // Convert LocalDate to milliseconds since epoch
            long milliseconds = value.atStartOfDay(ZoneOffset.UTC).toInstant().toEpochMilli();
            out.value(milliseconds);
        }
    }

    @Override
    public LocalDate read(JsonReader in) throws IOException {
        if (in.peek() == null) {
            return null;
        }
        long milliseconds = in.nextLong();
        return LocalDate.ofEpochDay(milliseconds / 86400000L); // Convert milliseconds to LocalDate
    }
}
