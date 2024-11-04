import 'package:core_feature/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';

enum MeasurementCardItem {
  distance,
  averagePace,
  verticalOscillation,
  cadence,
  groundContactTime,
  strideLength,
  averageSpeed,
  totalTime;

  String title(BuildContext context) {
    final translations = S.of(context);
    switch (this) {
      case MeasurementCardItem.distance:
        return translations.tracking_distance;
      case MeasurementCardItem.averagePace:
        return translations.tracking_average_pace;
      case MeasurementCardItem.verticalOscillation:
        return translations.tracking_vertical_oscillation;
      case MeasurementCardItem.cadence:
        return translations.tracking_cadence;
      case MeasurementCardItem.groundContactTime:
        return translations.tracking_ground_contact_time;
      case MeasurementCardItem.strideLength:
        return translations.tracking_stride_length;
      case MeasurementCardItem.averageSpeed:
        return translations.tracking_average_speed;
      case MeasurementCardItem.totalTime:
        return translations.tracking_total_time;
    }
  }

  String? _suffix(BuildContext context) {
    final translations = S.of(context);
    switch (this) {
      case MeasurementCardItem.distance:
        return translations.tracking_distance_suffix;
      case MeasurementCardItem.averagePace:
        return null;
      case MeasurementCardItem.verticalOscillation:
        return translations.tracking_vertical_oscillation_suffix;
      case MeasurementCardItem.cadence:
        return translations.tracking_cadence_suffix;
      case MeasurementCardItem.groundContactTime:
        return translations.tracking_ground_contact_time_suffix;
      case MeasurementCardItem.strideLength:
        return translations.tracking_stride_length_suffix;
      case MeasurementCardItem.averageSpeed:
        return translations.tracking_average_speed_suffix;
      case MeasurementCardItem.totalTime:
        return translations.tracking_total_time_suffix;
    }
  }

  String value(BuildContext context, MeasurementAnalysis? measurementAnalysis) {
    if (measurementAnalysis == null) {
      return "";
    }

    switch (this) {
      case MeasurementCardItem.distance:
        return "${measurementAnalysis.distance.toStringAsFixed(2)} ${_suffix(context)}";
      case MeasurementCardItem.averagePace:
        return "${measurementAnalysis.pace.toInt()}";
      case MeasurementCardItem.verticalOscillation:
        return "${(measurementAnalysis.verticalOscillation * 100).toInt()} ${_suffix(context)}";
      case MeasurementCardItem.cadence:
        return "${measurementAnalysis.cadence.toInt()} ${_suffix(context)}";
      case MeasurementCardItem.groundContactTime:
        return "${measurementAnalysis.groundContactTime.toInt()} ${_suffix(context)}";
      case MeasurementCardItem.strideLength:
        return "${measurementAnalysis.strideLength.toStringAsFixed(2)} ${_suffix(context)}";
      case MeasurementCardItem.averageSpeed:
        return "${measurementAnalysis.speed.toStringAsFixed(2)} ${_suffix(context)}";
      case MeasurementCardItem.totalTime:
        return "${measurementAnalysis.endTime.difference(measurementAnalysis.startTime).inMinutes} ${_suffix(context)}";
    }
  }
}
