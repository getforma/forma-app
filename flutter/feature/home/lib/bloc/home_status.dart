import 'package:core_feature/generated/l10n.dart';
import 'package:flutter/material.dart';

enum HomeStatus {
  initial,
  loading,
  nameError,
  sessionStarted,
  sessionStopped,
  sensorDisconnected,
  genericError;

  String? text(BuildContext context) {
    final translations = S.of(context);

    switch (this) {
      case HomeStatus.nameError:
        return translations.home_name_error;
      case HomeStatus.sessionStarted:
        return translations.home_session_started;
      case HomeStatus.sessionStopped:
        return translations.home_session_stopped;
      case HomeStatus.sensorDisconnected:
        return translations.home_sensor_disconnected;
      case HomeStatus.genericError:
        return translations.home_generic_error;
      default:
        return null;
    }
  }
}