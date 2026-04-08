import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static Future<void> setString(
      {required String key, required String? value}) async {
    await _storage.write(key: key, value: value).catchError((onError) {
      //todo: send to crashlytic
    });
  }

  static Future<String?> getString({required String key}) async {
    final result = await _storage.read(key: key).catchError((onError) {
      //todo: send to crashlytic
    });

    return result;
  }

  static Future<void> deleteKey({required String key}) async {
    await _storage.delete(key: key).catchError((onError) {
      //todo: send to crashlytic
    });
  }

  static Future<void> deleteAll({required String key}) async {
    await _storage.deleteAll().catchError((onError) {
      //todo: send to crashlytic
    });
  }

  static Future<void> containKeys({required String key}) async {
    await _storage.containsKey(key: key).catchError((onError) {
      //todo: send to crashlytic
    });
  }
}
