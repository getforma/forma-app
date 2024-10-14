import 'package:drift/drift.dart';

class MeasurementTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get sessionId => text().nullable()();

  RealColumn get longitude => real()();

  RealColumn get latitude => real()();

  TextColumn get sensorPosition => textEnum<MeasurementSensorPosition>()();

  RealColumn get accelerationX => real().nullable()();

  RealColumn get accelerationY => real().nullable()();

  RealColumn get accelerationZ => real().nullable()();

  RealColumn get angularVelocityX => real().nullable()();

  RealColumn get angularVelocityY => real().nullable()();

  RealColumn get angularVelocityZ => real().nullable()();

  RealColumn get magneticFieldX => real().nullable()();

  RealColumn get magneticFieldY => real().nullable()();

  RealColumn get magneticFieldZ => real().nullable()();

  RealColumn get angleX => real().nullable()();

  RealColumn get angleY => real().nullable()();

  RealColumn get angleZ => real().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  DateTimeColumn get timestamp => dateTime()();
}

enum MeasurementSensorPosition {
  pelvisBack,
  pelvisRight,
  shinRight,
  footRight,
}

