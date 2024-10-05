import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/service/sensor_messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut:
  'android/app/src/main/kotlin/app/getforma/forma/SensorMessages.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/SensorMessages.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'app_getforma_forma',
))
@HostApi()
abstract class SensorApi {
  void initialize();

  void startDiscovery();
}

@FlutterApi()
abstract class SensorFlutterApi {
  void onSensorDataRecorded(SensorData sensorData);
}

class SensorData {
  final String name;
  final ThreeAxisMeasurement acceleration;
  final ThreeAxisMeasurement angularVelocity;
  final ThreeAxisMeasurement magneticField;
  final ThreeAxisMeasurement angle;

  SensorData({
    required this.name,
    required this.acceleration,
    required this.angularVelocity,
    required this.magneticField,
    required this.angle,
  });
}

class ThreeAxisMeasurement {
  final double? x;
  final double? y;
  final double? z;

  ThreeAxisMeasurement({required this.x, required this.y, required this.z});
}
