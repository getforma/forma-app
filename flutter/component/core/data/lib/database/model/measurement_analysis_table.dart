import 'package:drift/drift.dart';

class MeasurementAnalysisTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text().nullable()();
  RealColumn get cadence => real()();
  RealColumn get distance => real()();
  DateTimeColumn get endTime => dateTime()();
  RealColumn get groundContactTime => real()();
  RealColumn get pace => real()();
  RealColumn get speed => real()();
  DateTimeColumn get startTime => dateTime()();
  RealColumn get strideLength => real()();
  RealColumn get verticalOscillation => real()();
}
