import 'package:dartz/dartz.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_info.dart';

abstract class SessionRepository {
  Future<Either<Exception, SessionInfo>> createSession({
    required String userName,
    required SensorPosition sensorPosition,
  });

  Future<Either<Exception, void>> storeMeasurementLocally({
    required SensorData data,
    double? longitude,
    double? latitude,
    SensorPosition? sensorPosition,
    required String sessionId,
  });

  Future<Either<Exception, MeasurementAnalysis>> stopSession();

  Stream<MeasurementAnalysis?> getMeasurementAnalysisStream(String sessionId);

  void dispose();
}
