import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'access_token';

  String? _token;
  var _hasReadToken = false;

  @override
  Future<String?> readToken() async {
    if (!_hasReadToken) {
      _token = await _storage.read(key: _tokenKey);
      _hasReadToken = true;
    }

    return _token;
  }

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    _token = token;
    _hasReadToken = true;
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    _token = null;
    _hasReadToken = true;
  }
}
