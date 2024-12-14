import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:text_to_speech_component_data/datasource/text_to_speech_datasource.dart';
import 'package:text_to_speech_component_data/model/text_to_speech_request.dart';
import 'package:text_to_speech_component_domain/text_to_speech_repository.dart';
import 'package:dartz/dartz.dart';

@LazySingleton(as: TextToSpeechRepository)
class TextToSpeechRepositoryImpl implements TextToSpeechRepository {
  final TextToSpeechDataSource _textToSpeechDataSource;

  TextToSpeechRepositoryImpl(this._textToSpeechDataSource);

  @override
  Future<Either<Exception, Uint8List>> getSpeechFromText(String text) async {
    try {
      final response = await _textToSpeechDataSource.getSpeechFromText(
        TextToSpeechRequest(text: text),
      );

      Uint8List soundbytes =
          response.buffer.asUint8List(response.offsetInBytes, response.lengthInBytes);
      // await player.play(BytesSource(soundbytes));

      return Right(soundbytes);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
