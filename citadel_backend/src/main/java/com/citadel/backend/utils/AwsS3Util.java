package com.citadel.backend.utils;

import com.citadel.backend.utils.Builder.RandomCodeBuilder;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.GetObjectPresignRequest;

import java.io.*;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.Duration;
import java.util.Base64;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

import static com.citadel.backend.utils.SpringUtil.getMessage;

public class AwsS3Util extends BaseService {
    protected static final Logger log = LoggerFactory.getLogger(AwsS3Util.class);
    final static String defaultPath = "uploads";
    final static String bucketFolder = getMessage("aws.bucket.folder");
    final static String awsAccessKeyId = getMessage("aws.access.key.id");
    final static String awsSecretKey = getMessage("aws.secret.access.key");
    final static String awsS3Host = getMessage("aws.s3.host");
    final static String awsBucketName = getMessage("aws.bucket.name");

    public static S3Client getS3Client() {
        AwsBasicCredentials awsCred = AwsBasicCredentials.create(awsAccessKeyId, awsSecretKey);

        return S3Client.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCred))
                .endpointOverride(URI.create(awsS3Host))
                .region(Region.US_EAST_1)  // Dummy region (DigitalOcean doesn't use AWS regions, but the SDK requires one)
                .build();
    }

    public static S3Presigner getS3Presigner() {
        AwsBasicCredentials awsCred = AwsBasicCredentials.create(awsAccessKeyId, awsSecretKey);

        // Build the S3Presigner with the same credentials and endpoint as S3Client
        return S3Presigner.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCred))
                .endpointOverride(URI.create(awsS3Host))
                .region(Region.US_EAST_1)  // Dummy region (DigitalOcean doesn't use AWS regions, but the SDK requires one)
                .build();
    }

    public static String getPublicURL(String keyName) {
        try {
            S3Client s3Client = getS3Client();
            GetUrlRequest request = GetUrlRequest.builder()
                    .bucket(awsBucketName)
                    .key(keyName)
                    .build();

            return s3Client.utilities().getUrl(request).toString();

        } catch (Exception ex) {
            log.error("Error Message: " + ex.getMessage(), ex);
            return null;
        }
    }

    public static String getS3DownloadUrl(String key) {
        if (StringUtil.isEmpty(key)) {
            return null;
        }
        //File is uploaded from CMS
        if (key.startsWith("[{\"download_link\"")) {
            key = StringUtil.extractDownloadLinkFromCmsContent(key);
        }
        if (!key.contains("citadel")) {
            key = bucketFolder + "/" + key;
        }
        // Create the S3Presigner (similar to the S3Client, but for presigned URLs)
        S3Presigner s3Presigner = getS3Presigner();

        // Build the GetObjectRequest with the key (file name)
        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(awsBucketName)
                .key(key)
                .build();

        // Specify the presigned URL duration
        GetObjectPresignRequest presignRequest = GetObjectPresignRequest.builder()
                .signatureDuration(Duration.ofHours(1))  // Expire after 1 hour
                .getObjectRequest(getObjectRequest)
                .build();

        // Generate the presigned URL
        String presignedUrl = s3Presigner.presignGetObject(presignRequest).url().toString();

        s3Presigner.close();
        return presignedUrl;
    }

    public static void uploadByteArray(byte[] byteArray, String filePath, boolean blockPublicAccess) {
        if (!filePath.startsWith(bucketFolder)) {
            filePath = bucketFolder + "/" + filePath;
        }
        final String finalFilePath = filePath;
        CompletableFuture.runAsync(() -> {
            try {
                log.info("Uploading a new object to S3 from byte array, FileName: " + finalFilePath);
                S3Client s3Client = getS3Client();
                PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                        .bucket(awsBucketName)
                        .key(finalFilePath)
                        .contentType(determineContentType(finalFilePath))
                        .acl(blockPublicAccess ? ObjectCannedACL.PRIVATE : ObjectCannedACL.PUBLIC_READ)
                        .build();

                // Upload directly from the byte array
                s3Client.putObject(putObjectRequest, RequestBody.fromBytes(byteArray));
                log.info("File uploaded successfully.");
            } catch (Exception ase) {
                log.error("Error Message: " + ase.getMessage(), ase);
            }
        });
    }

    public static void uploadFile(File file, String filePath, boolean blockPublicAccess) {
        if (!filePath.startsWith(bucketFolder)) {
            filePath = bucketFolder + "/" + filePath;
        }
        final String finalFilePath = filePath;
        CompletableFuture.runAsync(() -> {
            try {
                log.info("Uploading a new object to S3 from a file, FileName: " + file.getAbsolutePath());
                S3Client s3Client = getS3Client();
                PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                        .bucket(awsBucketName)
                        .key(finalFilePath)
                        .contentType(determineContentType(finalFilePath))
                        .acl(blockPublicAccess ? ObjectCannedACL.PRIVATE : ObjectCannedACL.PUBLIC_READ)
                        .build();

                PutObjectResponse result = s3Client.putObject(putObjectRequest, RequestBody.fromFile(file));
                log.info("MD5 Content: " + result.eTag());
                Boolean del = file.delete();
            } catch (Exception ase) {
                log.error("Error Message: " + ase.getMessage(), ase);
            }
        });
    }

    public static void deleteFile(String filePath) {
        if (StringUtil.isEmpty(filePath)) {
            return;
        }
        if (!filePath.startsWith(bucketFolder)) {
            filePath = bucketFolder + "/" + filePath;
        }
        final String finalFilePath = filePath;
        CompletableFuture.runAsync(() -> {
            try {
                log.info("Deleting object in S3, Filepath: " + finalFilePath);
                S3Client s3Client = getS3Client();
                DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                        .bucket(awsBucketName)
                        .key(finalFilePath)
                        .build();

                s3Client.deleteObject(deleteObjectRequest);
            } catch (Exception ase) {
                log.error("Error Message: " + ase.getMessage(), ase);
            }
        });
    }

    public static void uploadMultipartFile(MultipartFile multipartFile, String s3FilePath, Boolean blockPublicAccess) throws Exception {
        String filePath = "${file.storage.location}" + multipartFile.getOriginalFilename();
        // save local
        Files.copy(multipartFile.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        // upload s3
        File file = new File(filePath);
        uploadFile(file, s3FilePath, blockPublicAccess);
    }

    public static String determineContentType(String fileName) {
        if (fileName.endsWith(".png")) return "image/png";
        if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) return "image/jpeg";
        if (fileName.endsWith(".pdf")) return "application/pdf";
        return "application/octet-stream";
    }

    public static String convertAndUploadBase64File(UploadBase64FileBuilder builder) throws Exception {
        String base64String = builder.getBase64String();
        byte[] byteArray = StringUtil.decodeBase64ToFile(base64String);
        String extension = "." + MimeTypeUtil.getMimeType(byteArray);
        String fileName = StringUtil.isNotEmpty(builder.getFileName())
                ? (builder.getFileName() + extension)
                : (RandomCodeUtil.generateRandomCode(new RandomCodeBuilder().length(10)) + extension);

        String s3FilePath = bucketFolder + "/" + (StringUtil.isNotEmpty(builder.getFilePath())
                ? builder.getFilePath() + "/" + fileName
                : defaultPath + "/" + fileName);
        uploadByteArray(byteArray, s3FilePath, false);
        return s3FilePath;
    }

    public static String downloadFileToResources(String s3Key, String fileNameWithoutExtension) {
        // Define the base directory inside the resources folder of the Spring Boot project
        //String baseDir = Paths.get(STATIC_DOWNLOADS_PATH).toString();
        String baseDir = Paths.get(System.getProperty("user.dir"), "target", "classes", "static", "downloads").toString();
        String tempFilePath = Paths.get(baseDir, fileNameWithoutExtension).toString(); // Temporary path without extension

        if (!s3Key.startsWith(bucketFolder)) {
            s3Key = bucketFolder + "/" + s3Key;
        }

        try {
            log.info("Streaming file from S3. Key: {}, Temporary Destination: {}", s3Key, tempFilePath);

            // Ensure the directory exists
            File directory = new File(baseDir);
            if (!directory.exists()) {
                directory.mkdirs(); // Create the directory if it does not exist
            }

            // Create S3Client and prepare the request
            S3Client s3Client = getS3Client();
            GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                    .bucket(awsBucketName)
                    .key(s3Key)
                    .build();

            // Open S3 input stream and write to a temporary file
            try (InputStream inputStream = s3Client.getObject(getObjectRequest);
                 FileOutputStream outputStream = new FileOutputStream(tempFilePath)) {

                byte[] buffer = new byte[8192]; // 8 KB buffer size
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }

            log.info("File streamed successfully to temporary path: {}", tempFilePath);

            // Detect file type
            String fileExtension = determineFileType(tempFilePath, s3Key);

            // Rename the file to include the correct extension
            String finalFileName = fileNameWithoutExtension + fileExtension;
            String finalFilePath = Paths.get(baseDir, finalFileName).toString();
            // Handle existing files by overwriting
            Path tempPath = Paths.get(tempFilePath);
            Path finalPath = Paths.get(finalFilePath);
            if (Files.exists(finalPath)) {
                Files.delete(finalPath); // Delete existing file
            }
            Files.move(Paths.get(tempFilePath), Paths.get(finalFilePath));

            log.info("File renamed to include extension: {}", finalFilePath);
            //String relativePath = finalFilePath.replace(Paths.get(STATIC_RESOURCES_PATH).toString(), "");
            String relativePath = "/static/downloads/" + finalFileName;
            return relativePath; // Return the full path with the correct extension

        } catch (Exception ex) {
            log.error("Error occurred while streaming file from S3. Key: {}, Error: {}", s3Key, ex.getMessage(), ex);
            // Cleanup temp file in case of error
            try {
                Files.deleteIfExists(Paths.get(tempFilePath));
            } catch (IOException cleanupEx) {
                log.warn("Failed to clean up temporary file: {}", tempFilePath, cleanupEx);
            }
            return null; // Return null if download fails
        }
    }

    public static String downloadFileToBase64(String s3Key) throws Exception {
        if (!s3Key.startsWith(bucketFolder)) {
            s3Key = bucketFolder + "/" + s3Key;
        }

        S3Client s3Client = getS3Client();
        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(awsBucketName)
                .key(s3Key)
                .build();

        Thread.sleep(3000);//Buffer for file/image to be uploaded to S3 before downloading
        try (InputStream inputStream = s3Client.getObject(getObjectRequest);
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {

            // Buffer and stream the data
            byte[] buffer = new byte[8192]; // 8 KB buffer
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            // Encode the byte array to Base64
            byte[] fileBytes = outputStream.toByteArray();
            String base64String = Base64.getEncoder().encodeToString(fileBytes);
            String fileExtension = getFileTypeFromBase64(base64String);
            return "data:" + fileExtension + ";base64," + base64String;
        }
    }

    // Directly stream the file from S3 to the user's downloads folder to avoid loading the byte array into memory
    public static String downloadFile(String s3Key, String fileNameWithoutExtension) {
        String baseDir = System.getProperty("java.io.tmpdir") + File.separator + "downloads";
        String tempFilePath = Paths.get(baseDir, fileNameWithoutExtension).toString(); // Temporary path without extension

        if (!s3Key.startsWith(bucketFolder)) {
            s3Key = bucketFolder + "/" + s3Key;
        }

        try {
            log.info("Streaming file from S3. Key: {}, Temporary Destination: {}", s3Key, tempFilePath);

            // Ensure the directory exists
            File directory = new File(baseDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            // Create S3Client and prepare the request
            S3Client s3Client = getS3Client();
            GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                    .bucket(awsBucketName)
                    .key(s3Key)
                    .build();

            // Open S3 input stream and write to a temporary file
            try (InputStream inputStream = s3Client.getObject(getObjectRequest);
                 FileOutputStream outputStream = new FileOutputStream(tempFilePath)) {

                byte[] buffer = new byte[8192]; // 8KB buffer size
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }

            log.info("File streamed successfully to temporary path: {}", tempFilePath);

            // Detect file type
            String fileExtension = determineFileType(tempFilePath, s3Key);

            // Rename the file to include the correct extension
            String finalFileName = fileNameWithoutExtension + fileExtension;
            String finalFilePath = Paths.get(baseDir, finalFileName).toString();
//            Files.move(Paths.get(tempFilePath), Paths.get(finalFilePath));
            Files.move(Paths.get(tempFilePath), Paths.get(finalFilePath), StandardCopyOption.REPLACE_EXISTING);

            log.info("File renamed to include extension: {}", finalFilePath);
            return finalFilePath; // Return the full path with the correct extension

        } catch (Exception ex) {
            log.error("Error occurred while streaming file from S3. Key: {}, Error: {}", s3Key, ex.getMessage(), ex);
            return null; // Return null if download fails
        }
    }

    private static String determineFileType(String filePath, String s3Key) throws IOException {
        // Try to extract the file extension from the S3 key
        int lastDotIndex = s3Key.lastIndexOf('.');
        if (lastDotIndex != -1 && lastDotIndex < s3Key.length() - 1) {
            String extractedExtension = s3Key.substring(lastDotIndex).toLowerCase();
            log.info("File extension extracted from S3 key: {}", extractedExtension);
            return extractedExtension; // Return the extracted extension
        }

        //Failsafe is s3Key don't have file extension
        String mimeType = Files.probeContentType(Paths.get(filePath));
        if (mimeType == null) {
            log.warn("Unable to determine file type, defaulting to .bin");
            return ".bin"; // Default extension if file type cannot be determined
        }

        // Map MIME type to file extension
        return switch (mimeType) {
            case "image/png" -> ".png";
            case "image/jpeg" -> ".jpg";
            case "application/pdf" -> ".pdf";
            case "text/plain" -> ".txt";
            case "application/zip" -> ".zip";
            case "text/html" -> ".html";
            default -> {
                log.warn("Unknown MIME type: {}", mimeType);
                yield ".bin";
            }
        };
    }

    public static String downloadHtmlContentAsString(String s3Key) {
        if (!s3Key.startsWith(bucketFolder)) {
            s3Key = bucketFolder + "/" + s3Key;
        }

        try {
            S3Client s3Client = getS3Client();
            GetObjectRequest request = GetObjectRequest.builder()
                    .bucket(awsBucketName)
                    .key(s3Key)
                    .build();

            try (InputStream inputStream = s3Client.getObject(request);
                 BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                return reader.lines().collect(Collectors.joining("\n"));
            }
        } catch (Exception e) {
            log.error("Error reading HTML content from S3 key: {}", s3Key, e);
            throw new RuntimeException("Failed to read HTML template from S3", e);
        }
    }

}
