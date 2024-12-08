import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:recommendation_component_data/datasource/recommendation_datasource.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';
import 'package:recommendation_component_domain/recommendation_repository.dart';

@LazySingleton(as: RecommendationRepository)
class RecommendationRepositoryImpl implements RecommendationRepository {
  final RecommendationDataSource _recommendationDataSource;

  RecommendationRepositoryImpl(this._recommendationDataSource);

  @override
  Future<Either<Exception, List<Recommendation>>> getRecommendations() async {
    try {
      return Right(await _recommendationDataSource.getRecommendations());
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
