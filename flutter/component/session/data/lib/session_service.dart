import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:session_component_data/model/analyze_session_data_body.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/model/session_measurement.dart';
import 'package:session_component_domain/model/session_request.dart';

part 'session_service.g.dart';

@RestApi()
@lazySingleton
abstract class SessionService {
  @factoryMethod
  factory SessionService(Dio dio) = _SessionService;

  @POST("/sessions")
  Future<HttpResponse<SessionInfo>> createSession(@Body() SessionRequest body);

  @POST("/sessions/{id}/track")
  Future<HttpResponse<MeasurementAnalysis>> trackSessionData(
      @Path("id") String id, @Body() List<SessionMeasurement> body);

  @POST("/sessions/{id}/analyze")
  Future<HttpResponse<MeasurementAnalysis>> analyzeSessionData(
      @Path("id") String id, @Body() AnalyzeSessionDataBody body);
}
