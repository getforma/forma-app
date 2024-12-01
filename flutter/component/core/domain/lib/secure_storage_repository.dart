abstract class SecureStorageRepository {
  Future<void> setAccessToken(String accessToken);
  Future<String?> getAccessToken();
}
