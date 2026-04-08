package com.citadel.backend.utils;

import org.apache.tika.config.TikaConfig;
import org.apache.tika.exception.TikaException;
import org.apache.tika.io.TikaInputStream;
import org.apache.tika.metadata.Metadata;
import org.apache.tika.mime.MediaType;
import org.apache.tika.mime.MimeType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class MimeTypeUtil {
    protected static final Logger log = LoggerFactory.getLogger(MimeTypeUtil.class);
    public static final TikaConfig tikaConfig = getTikaConfig();

    public static TikaConfig getTikaConfig() {
        try {
            return new TikaConfig();
        } catch (TikaException | IOException ex) {
            log.error("Error while creating TikaConfig", ex);
        }
        return null;
    }

    public static String getMimeType(byte[] decodedBase64) {
        String extension = "UNKNOWN";
        try {
            if (tikaConfig == null) {
                log.error("TikaConfig is null");
                return extension;
            }
            MediaType mediaType = tikaConfig.getDetector()
                    .detect(TikaInputStream
                            .get(decodedBase64), new Metadata());
            MimeType mimeType = tikaConfig.getMimeRepository().forName(mediaType.toString());
            if (mediaType.toString().equalsIgnoreCase("application/x-tika-ooxml"))
                extension = "xlsx";
            else
                extension = mimeType.getExtension().split("\\.")[1];
        } catch (Exception ex) {
            log.error("Error while getting MimeType", ex);
        }
        return extension;
    }
}
