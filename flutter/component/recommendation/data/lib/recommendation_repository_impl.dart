import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:recommendation_component_data/datasource/recommendation_datasource.dart';
import 'package:recommendation_component_data/datasource/recommendation_local_datasource.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';
import 'package:recommendation_component_domain/recommendation_repository.dart';

@LazySingleton(as: RecommendationRepository)
class RecommendationRepositoryImpl implements RecommendationRepository {
  final RecommendationDataSource _recommendationDataSource;
  final RecommendationLocalDataSource _recommendationLocalDataSource;

  RecommendationRepositoryImpl(
    this._recommendationDataSource,
    this._recommendationLocalDataSource,
  );

  @override
  Future<Either<Exception, List<Recommendation>>>
      updateRecommendations() async {
    try {
      final recommendations =
          await _recommendationDataSource.getRecommendations();
      await _recommendationLocalDataSource.saveRecommendations(recommendations);
      return Right(recommendations);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Stream<List<Recommendation>> getRecommendationsStream() {
    return _recommendationLocalDataSource.getRecommendationsStream();
  }
}
