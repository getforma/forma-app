import 'package:core_component_domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';
import 'package:recommendation_component_domain/recommendation_repository.dart';

@injectable
class GetRecommendationsStreamUseCase
    implements SynchronousUseCase<EmptyParam, Stream<List<Recommendation>>> {
  final RecommendationRepository _recommendationRepository;

  GetRecommendationsStreamUseCase(this._recommendationRepository);

  @override
  Stream<List<Recommendation>> invoke(EmptyParam param) {
    return _recommendationRepository.getRecommendationsStream();
  }
}
