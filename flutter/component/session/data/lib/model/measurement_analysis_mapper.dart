import 'package:core_component_data/database/app_database.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';

extension MeasurementAnalysisMapper on MeasurementAnalysisTableData {
  MeasurementAnalysis toDomain() => MeasurementAnalysis(
        cadence: cadence,
        distance: distance,
        endTime: endTime,
        groundContactTime: groundContactTime,
        pace: pace,
        speed: speed,
        startTime: startTime,
        strideLength: strideLength,
        verticalOscillation: verticalOscillation,
      );
}
