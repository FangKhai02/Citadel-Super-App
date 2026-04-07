<?php

namespace App\Util;


use Aws\Credentials\CredentialProvider;
use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;
use Illuminate\Support\Str;

class Util
{
    /** @var string */
    private static $clientKey;

    /** @var string */
    private static $clientSecret;

    /** @var string */
    private static $region;

    /** @var string */
    private static $bucket;

    /** @var string */
    private static $rootFolder;

    /** @var string */
    private static $endpoint;

    public static function __constructStatic()
    {
        static::$clientKey = env('AWS_ACCESS_KEY_ID');
        static::$clientSecret = env('AWS_SECRET_ACCESS_KEY');
        static::$region = env('AWS_DEFAULT_REGION');
        static::$bucket = env('AWS_BUCKET');
        static::$rootFolder = 'citadel'; // Set root folder directly as 'citadel'
        static::$endpoint = env('AWS_ENDPOINT');
    }

    public static function getS3PDFDownloadUrl($key)
    {
        Util::__constructStatic();
        try {
            $s3Client = new S3Client([
                'version' => 'latest',
                'region' => self::$region,
                'credentials' => [
                    'key' => self::$clientKey,
                    'secret' => self::$clientSecret
                ],
                'bucket_endpoint' => false,
                'use_path_style_endpoint' => false,
                'endpoint' => self::$endpoint,
            ]);

            // Remove 'citadel/' prefix from the key if it already exists
            $sanitizedKey = preg_replace('/^' . preg_quote(self::$rootFolder, '/') . '\//', '', $key);

            // Build the final full key
            $fullKey = self::$rootFolder . '/' . $sanitizedKey;

            $cmd = $s3Client->getCommand('GetObject', [
                'Bucket' => self::$bucket,
                'Key' => $fullKey,
            ]);


            $request = $s3Client->createPresignedRequest($cmd, '+20 minutes');
            $presignedUrl = (string)$request->getUri();

            return $presignedUrl;
        } catch (S3Exception $s3Exception) {
            throw $s3Exception;
        }
    }

    public static function getS3FileDownloadUrlWithOriginalFileName($key, $originalFileName)
    {
        Util::__constructStatic();
        try {
            $s3Client = new S3Client([
                'version' => 'latest',
                'region' => self::$region,
                'credentials' => [
                    'key' => self::$clientKey,
                    'secret' => self::$clientSecret
                ],
                'bucket_endpoint' => false,
                'use_path_style_endpoint' => false,
                'endpoint' => self::$endpoint,
            ]);

            $cmd = $s3Client->getCommand('GetObject', [
                'Bucket' => self::$bucket,
                'Key' => self::$rootFolder . '/' . $key,
                'ResponseContentDisposition' => 'attachment; filename="'.$originalFileName.'"',
            ]);

            $request = $s3Client->createPresignedRequest($cmd, '+20 minutes');
            $presignedUrl = (string)$request->getUri();

            return $presignedUrl;
        } catch (S3Exception $s3Exception) {
            throw $s3Exception;
        }
    }

    public static function findRelationFieldForControllerQuery($dataType, string $searchKey)
    {
        foreach ($dataType->browseRows as $key => $row) {
            if ($row->type === "relationship" &&
                Str::Lower($row->field) === $searchKey) {
                if ($row->details->type === "belongsTo")
                    return [Str::singular(Str::camel($row->details->table)), $row->details->label];
                else if ($row->details->type === "belongsToMany")
                    return [Str::plural(Str::camel($row->details->table)), $row->details->label];
                else if ($row->details->type === "hasOne")
                    return [Str::singular(Str::camel($row->details->table)), $row->details->label];
            }
        }
        return $searchKey;
    }

    public static function findRelationFieldForViewSearchForm($dataType, string $searchKey)
    {
        foreach ($dataType->browseRows as $key => $row) {
            if (Str::Lower($row->field) === $searchKey) {
                $isRelationship = $row->type === "relationship" &&
                    ($row->details->type === "belongsTo" || $row->details->type === "belongsToMany" || $row->details->type === "hasOne");
                $isCheckbox = $row->type === "checkbox";
                if ($isRelationship || $isCheckbox)
                    return $row->display_name;
            }
        }
        return $searchKey;
    }

    public static function findSearchValue($dataType, string $searchKey, string $searchFilter, string $searchValue)
    {
        foreach ($dataType->browseRows as $key => $row) {
            if ($row->type === "checkbox" &&
                Str::Lower($row->field) === $searchKey) {
                if (stripos($row->details->on, $searchValue) !== false)
                    return 1; // $searchValue
                else if (stripos($row->details->off, $searchValue) !== false)
                    return 0; // $searchValue
            }
        }
        return ($searchFilter == 'equals') ? $searchValue : '%'.$searchValue.'%';
    }
}
