import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'AccessToken', value: token);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: 'AccessToken');
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'RefreshToken', value: token);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: 'RefreshToken');
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }
}
