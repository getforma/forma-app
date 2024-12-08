import 'package:drift/drift.dart';

class RecommendationTable extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get trainingType => textEnum<RecommendationType>()();

  @override
  Set<Column> get primaryKey => {date};
}

enum RecommendationType {
  long,
  intervals,
  easy,
  tempo,
  hills,
  rest,
  strength,
  cross,
  moderate,
  fartlek,
}
