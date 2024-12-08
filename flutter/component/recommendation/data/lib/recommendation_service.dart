import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:recommendation_component_data/model/recommendation_response.dart';
import 'package:retrofit/retrofit.dart';

part 'recommendation_service.g.dart';

@RestApi()
@injectable
abstract class RecommendationService {
  @factoryMethod
  factory RecommendationService(Dio dio) = _RecommendationService;

  @GET('/recommendation')
  Future<HttpResponse<RecommendationResponse>> getRecommendation();
}
