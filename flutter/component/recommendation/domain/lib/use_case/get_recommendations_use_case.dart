import 'package:dartz/dartz.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';
import 'package:injectable/injectable.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:recommendation_component_domain/recommendation_repository.dart';

@injectable
class GetRecommendationsUseCase
    extends UseCase<EmptyParam, List<Recommendation>> {
  final RecommendationRepository _recommendationRepository;

  GetRecommendationsUseCase(this._recommendationRepository);

  @override
  Future<Either<Exception, List<Recommendation>>> invoke(
          EmptyParam param) async =>
      _recommendationRepository.getRecommendations();
}
