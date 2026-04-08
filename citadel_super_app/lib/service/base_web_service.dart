import 'dart:io';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:citadel_super_app/service/package_info_service.dart';
import 'package:citadel_super_app/service/session_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum WebServiceHTTPMethod { GET, POST, PUT, DELETE }

class BaseException {
  String message;

  BaseException(this.message);
}

class ApiException extends BaseException {
  String url;

  ApiException(String message, this.url) : super(message);
}

class ServerError extends ApiException {
  ServerError(String url) : super('service.error', url);
}

class ServerUnderMaintenance extends ApiException {
  final String? startDatetime;
  final String? endDatetime;

  ServerUnderMaintenance(String url, this.startDatetime, this.endDatetime)
      : super('service.under.maintenance', url);
}

class InvalidSessionException extends ApiException {
  InvalidSessionException(String url)
      : super('app.received.user.invalid.session', url);
}

class TimeOutException extends ApiException {
  TimeOutException(String url) : super('app.received.timeout', url);
}

class AppDioException extends ApiException {
  String dioError;

  AppDioException(String url, this.dioError)
      : super('app.received.dio.exception', url);
}

class NoInternetException extends ApiException {
  NoInternetException(String url) : super('app.no.internet.connection', url);
}

class UnknownException extends ApiException {
  String unknownError;
  int? statusCode;

  UnknownException(String url, this.unknownError, this.statusCode)
      : super('app.received.unknown', url);
}

class ServerInvalidResponseException extends ApiException {
  String data;

  ServerInvalidResponseException(String url, this.data)
      : super('app.received.server.invalid.response', url);
}

class StatusCodeException extends ApiException {
  int? statusCode;

  StatusCodeException(String url, this.statusCode)
      : super('app.received.status.code.exception', url);
}

class ResponseErrorException extends ApiException {
  ResponseErrorException(String url, String message) : super(message, url);
}

abstract class BaseWebService {
  int timeout = 120000;
  String? customApiKey;
  Map<String, String>? customHeader;
  DateTime? _startTime;

  Future<Map<String, String>> getHeader() async {
    String? value = SessionService.apiKey;
    Map<String, String> header = <String, String>{
      'apiKey': customApiKey ?? value ?? ''
    };

    if ((header['apiKey'] as String).isEmpty) {
      header = {};
    }

    if (customHeader != null) {
      header.addAll(customHeader!);
    }

    header.addAll(getVersionAndOperatingHeader());

    return header;
  }

  Map<String, String> getVersionAndOperatingHeader() {
    Map<String, String> header = {};
    header['appVersion'] = PackageInfoService.instance.packageVersion ?? '';
    header['buildNumber'] =
        PackageInfoService.instance.packageBuildNumber ?? '';

    return header;
  }

  Future<Map<String, dynamic>> get({
    required String url,
  }) async {
    final header = await getHeader();
    return await _apiCallBegin(
        WebServiceHTTPMethod.GET, url, header, null, null);
  }

  Future<Map<String, dynamic>> post({
    required String url,
    Map<String, dynamic>? parameter,
    FormData? formData,
  }) async {
    final header = await getHeader();
    return await _apiCallBegin(
        WebServiceHTTPMethod.POST, url, header, parameter, formData);
  }

  Future<Map<String, dynamic>> put({
    required String url,
  }) async {
    final header = await getHeader();
    return await _apiCallBegin(
        WebServiceHTTPMethod.PUT, url, header, null, null);
  }

  Future<Map<String, dynamic>> delete({
    required String url,
  }) async {
    final header = await getHeader();
    return await _apiCallBegin(
        WebServiceHTTPMethod.DELETE, url, header, null, null);
  }

  Future<Map<String, dynamic>> _apiCallBegin(
    WebServiceHTTPMethod httpMethod,
    String url,
    Map<String, dynamic> header,
    Map<String, dynamic>? parameter,
    FormData? formData,
  ) async {
    _startTime = DateTime.now();

    Dio dio = Dio();
    dio.options.connectTimeout = Duration(milliseconds: timeout);
    dio.options.receiveTimeout = Duration(milliseconds: timeout);
    dio.options.headers = header;
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: kDebugMode,
        requestBody: false,
        responseBody: false,
        logPrint: appDebugPrint,
      ),
    );

    Response response;
    try {
      switch (httpMethod) {
        case WebServiceHTTPMethod.GET:
          response = await dio.get(url);
          break;
        case WebServiceHTTPMethod.POST:
          response = await dio.post(url, data: parameter ?? formData);
          break;
        case WebServiceHTTPMethod.DELETE:
          response = await dio.delete(url);
          break;
        case WebServiceHTTPMethod.PUT:
          response = await dio.put(url);
          break;
      }

      /// Invalid Server Response Error
      if (response.data is! Map<String, dynamic>) {
        throw ServerInvalidResponseException(url, response.data);
      }

      Map<String, dynamic> responseMap =
          Map<String, dynamic>.from(response.data);

      /// Backend Error Response
      if (responseMap['code'] != '200') {
        if (responseMap['code'] == '500' &&
            responseMap['message'] == 'api.server.maintenance') {
          throw ServerUnderMaintenance(
            url,
            responseMap['startDatetime'],
            responseMap['endDatetime'],
          );
        } else {
          throw ResponseErrorException(url, responseMap['message'] ?? '');
        }
      }

      return responseMap;
    } on DioException catch (e, s) {
      appDebugPrint(
          '[!][!][!] API EXCEPTION\nURL: $url\nRES:${e.toString()}\n$s');
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw TimeOutException(url);
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 400) {
            throw ResponseErrorException(url, e.response?.data['message']);
          }
          if (e.response?.statusCode == 403) {
            SessionService.deleteSession();
            throw InvalidSessionException(url);
          }
          if (e.response?.statusCode == 404) {
            throw ServerError(url);
          }

          throw StatusCodeException(url, e.response?.statusCode);
        case DioExceptionType.connectionError:
          throw ServerError(url);
        case DioExceptionType.unknown:
          if (e.error
              .toString()
              .contains('No address associated with hostname')) {
            throw NoInternetException(url);
          }
          throw AppDioException(url, e.error.toString());
        default:
          throw AppDioException(url, e.error.toString());
      }
    } on SocketException {
      throw NoInternetException(url);
    } catch (e) {
      throw UnknownException(url, e.toString(), null);
    } finally {
      DateTime endTime = DateTime.now();
      int diff = endTime.difference(_startTime!).inMilliseconds;
      appDebugPrint('----------------------------');
      appDebugPrint('URL : $url');
      appDebugPrint('Start Time : $_startTime');
      appDebugPrint('End Time : $endTime');
      appDebugPrint('Diff : $diff');
      appDebugPrint('----------------------------');
    }
  }
}
