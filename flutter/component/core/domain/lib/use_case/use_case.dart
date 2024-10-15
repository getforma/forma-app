import 'package:dartz/dartz.dart';

abstract class UseCase<Param, Result> {
  Future<Either<Exception, Result>> invoke(Param param);
}

abstract class SynchronousUseCase<Param, Result> {
  Result invoke(Param param);
}

abstract class NotLensUseCase<Param, Result> {
  Future<Result> invoke(Param param);
}

class EmptyParam {}
