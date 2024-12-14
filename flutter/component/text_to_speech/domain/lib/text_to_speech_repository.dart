import 'package:dartz/dartz.dart';

abstract class TextToSpeechRepository {
  Future<Either<Exception, Unit>> getSpeechFromText(String text);

  void dispose();
}
