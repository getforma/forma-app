abstract class AppConfigurationRepository {
  Stream<bool> getIsSensorConnectedStream();
  Future<void> setIsSensorConnected(bool isConnected);
  Future<void> setCurrentSessionId(String sessionId);
  Stream<String?> getCurrentSessionIdStream();
  Future<String?> getCurrentSessionId();
  Future<void> removeCurrentSessionId();
  Future<void> setOnboardingCompleted();
  Future<bool> getOnboardingCompleted();
  void dispose();
}

