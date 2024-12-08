import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'recommendation_service.g.dart';

@RestApi()
@injectable
abstract class RecommendationService {
  @factoryMethod
  factory RecommendationService(Dio dio) = _RecommendationService;
}
