import 'package:dartz/dartz.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';

abstract class RecommendationRepository {
  Future<Either<Exception, List<Recommendation>>> getRecommendations();
}
