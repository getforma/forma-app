import 'package:core_component_data/database/app_database.dart';
import 'package:core_component_data/database/model/recommendation_table.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:recommendation_component_data/model/recommendation_mapper.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';
import 'package:recommendation_component_domain/model/recommendation_type.dart'
    as d;

@injectable
class RecommendationLocalDataSource {
  final AppDatabase _database;

  RecommendationLocalDataSource(this._database);

  Future<void> saveRecommendations(List<Recommendation> recommendations) async {
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(
          _database.recommendationTable,
          recommendations.map((e) => RecommendationTableCompanion(
                date: Value(e.date),
                trainingType: Value(mapToDbType(e.trainingType)),
              )));
    });
  }

  Future<List<Recommendation>> getRecommendations({int limit = 5}) async {
    return (_database.select(_database.recommendationTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
          ])
          ..limit(limit))
        .get()
        .then((value) => value.map((e) => e.toDomain()).toList());
  }

  Stream<List<Recommendation>> getRecommendationsStream({int limit = 5}) {
    return (_database.select(_database.recommendationTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
          ])
          ..limit(limit))
        .watch()
        .map((value) => value.map((e) => e.toDomain()).toList());
  }

  RecommendationType mapToDbType(d.RecommendationType type) {
    switch (type) {
      case d.RecommendationType.easy:
        return RecommendationType.easy;
      case d.RecommendationType.long:
        return RecommendationType.long;
      case d.RecommendationType.intervals:
        return RecommendationType.intervals;
      case d.RecommendationType.tempo:
        return RecommendationType.tempo;
      case d.RecommendationType.hills:
        return RecommendationType.hills;
    }
  }
}
