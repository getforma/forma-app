import 'package:flutter/material.dart';
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
class SensorData {
  double? temperature;
  double? humidity;
}

@HostApi()
abstract class SensorApi {
  void initialize(BuildContext context);

  void startDiscovery();

  @async
  SensorData getSensorData();
}
