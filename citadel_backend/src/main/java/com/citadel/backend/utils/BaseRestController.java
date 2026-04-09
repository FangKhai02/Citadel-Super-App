package com.citadel.backend.utils;

import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.utils.Constant.*;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import com.google.gson.stream.JsonToken;
import io.swagger.v3.oas.annotations.Hidden;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.Map;

public abstract class BaseRestController {

    @Value("${project.url}")
    public String HOST;

    @Value("${server.env}")
    public String ENV;

    public Logger log = LoggerFactory.getLogger(getClass());

    private static final Gson CASE_INSENSITIVE_GSON = new GsonBuilder()
            .registerTypeAdapterFactory(new CaseInsensitiveEnumTypeAdapterFactory())
            .create();

    public Gson gson = CASE_INSENSITIVE_GSON;

    public static final String SUCCESS = "200";
    public final static String ERROR_EXCEPTION = "500";

    @Hidden
    @RequestMapping(value = "**")
    @ResponseBody
    protected ErrorResp handleResourceNotFound() {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(HttpCode.RESOURCE_NOT_FOUND.getMessage());
        return errorResp;
    }

    public ErrorResp getErrorException(Exception ex) {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(ex.getMessage());
        return errorResp;
    }

    protected String getFunctionName() {
        return new Throwable()
                .getStackTrace()[1]
                .getMethodName();
    }
}

class CaseInsensitiveEnumTypeAdapterFactory implements TypeAdapterFactory {
    @Override
    @SuppressWarnings("unchecked")
    public <T> TypeAdapter<T> create(Gson gson, TypeToken<T> type) {
        if (!type.getRawType().isEnum()) {
            return null;
        }

        final Map<String, T> nameToValue = new HashMap<>();
        for (Object enumConstant : type.getRawType().getEnumConstants()) {
            Enum<?> e = (Enum<?>) enumConstant;
            nameToValue.put(e.name(), (T) enumConstant);
            nameToValue.put(e.name().toLowerCase(), (T) enumConstant);
        }

        return new TypeAdapter<T>() {
            @Override
            public void write(JsonWriter out, T value) throws IOException {
                if (value == null) {
                    out.nullValue();
                } else {
                    out.value(value.toString());
                }
            }

            @Override
            public T read(JsonReader in) throws IOException {
                if (in.peek() == JsonToken.NULL) {
                    in.nextNull();
                    return null;
                }
                String name = in.nextString();
                T result = nameToValue.get(name);
                if (result == null) {
                    result = nameToValue.get(name.toUpperCase());
                }
                if (result == null) {
                    throw new JsonParseException("Unknown enum value: " + name);
                }
                return result;
            }
        };
    }
}
