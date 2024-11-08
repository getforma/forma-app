abstract class AppConfigurationRepository {
  Stream<bool> getIsSensorConnectedStream();
  Future<void> setIsSensorConnected(bool isConnected);
}

