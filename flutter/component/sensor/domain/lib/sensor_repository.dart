abstract class SensorRepository {
  Future<bool> initialize();

  void startDiscovery();
}