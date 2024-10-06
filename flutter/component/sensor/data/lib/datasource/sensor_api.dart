import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'sensor_messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      '../../../../../../android/app/src/main/kotlin/app/getforma/forma/SensorMessages.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: '../../../../../../ios/Runner/SensorMessages.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'app_getforma_forma',
))
@HostApi()
abstract class SensorApi {
  void initialize();

  void startDiscovery();
}

@FlutterApi()
abstract class SensorCallbackApi {
  void onSensorDataRecorded(SensorDataModel sensorData);
}

class SensorDataModel {
  final String name;
  final ThreeAxisMeasurementModel acceleration;
  final ThreeAxisMeasurementModel angularVelocity;
  final ThreeAxisMeasurementModel magneticField;
  final ThreeAxisMeasurementModel angle;

  SensorDataModel({
    required this.name,
    required this.acceleration,
    required this.angularVelocity,
    required this.magneticField,
    required this.angle,
  });
}

class ThreeAxisMeasurementModel {
  final double? x;
  final double? y;
  final double? z;

  ThreeAxisMeasurementModel(
      {required this.x, required this.y, required this.z});
}
