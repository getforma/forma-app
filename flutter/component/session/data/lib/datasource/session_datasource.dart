import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:session_component_data/session_service.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/model/session_measurement.dart';
import 'package:session_component_domain/model/session_request.dart';

abstract class SessionDataSource {
  Future<SessionInfo> createSession(SessionRequest body);

  Future<MeasurementAnalysis> trackSessionData(
      String sessionId, List<SessionMeasurement> body);
}

@LazySingleton(as: SessionDataSource)
class SessionDataSourceImpl implements SessionDataSource {
  final SessionService _sessionService;

  SessionDataSourceImpl(this._sessionService);

  @override
  Future<SessionInfo> createSession(SessionRequest body) async {
    final response = await _sessionService.createSession(body);
    if (response.response.statusCode == HttpStatus.created) {
      return response.data;
    }
    throw Exception(response.data);
  }

  @override
  Future<MeasurementAnalysis> trackSessionData(
      String sessionId, List<SessionMeasurement> body) async {
    final response = await _sessionService.trackSessionData(sessionId, body);
    if (response.response.statusCode == HttpStatus.created) {
      return response.data;
    }
    throw Exception(response.data);
  }
}
