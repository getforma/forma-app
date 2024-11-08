import 'package:injectable/injectable.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';
import 'package:sensor_component_domain/sensor_repository.dart';

@LazySingleton(as: SensorRepository)
class SensorRepositoryImpl implements SensorRepository {
  final SensorApi _sensorApi = SensorApi();

  @override
  Future<bool> initialize() async {
    return _sensorApi.initialize();
  }

  @override
  Future<void> startDiscovery() async {
    await _sensorApi.startDiscovery();
  }
}
