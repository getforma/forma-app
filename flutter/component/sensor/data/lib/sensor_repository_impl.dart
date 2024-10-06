import 'package:sensor_component_domain/sensor_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SensorRepository)
class SensorRepositoryImpl implements SensorRepository {
  @override
  String hello() {
    return "Hello";
  }
}
