import 'package:dartz/dartz.dart';

abstract class UseCase<Param, Result> {
  Future<Either<Exception, Result>> invoke(Param param);
}

class EmptyParam {}
