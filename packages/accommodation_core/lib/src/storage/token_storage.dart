abstract interface class TokenStorage {
  Future<String?> readToken();

  Future<void> saveToken(String token);

  Future<void> deleteToken();
}
