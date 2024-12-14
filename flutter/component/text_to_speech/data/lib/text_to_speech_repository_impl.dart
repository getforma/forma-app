import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:text_to_speech_component_data/audio_player_bytes_source.dart';
import 'package:text_to_speech_component_data/datasource/text_to_speech_datasource.dart';
import 'package:text_to_speech_component_data/model/text_to_speech_request.dart';
import 'package:text_to_speech_component_domain/text_to_speech_repository.dart';

@LazySingleton(as: TextToSpeechRepository)
class TextToSpeechRepositoryImpl implements TextToSpeechRepository {
  final TextToSpeechDataSource _textToSpeechDataSource;
  late final AudioPlayer _player;

  TextToSpeechRepositoryImpl(this._textToSpeechDataSource);

  @postConstruct
  void init() {
    _player = AudioPlayer();
  }

  @override
  Future<Either<Exception, Unit>> getSpeechFromText(String text) async {
    try {
      final response = await _textToSpeechDataSource.getSpeechFromText(
        TextToSpeechRequest(text: text),
      );

      await _player.setAudioSource(AudioPlayerBytesSource(response));
      await _player.play();

      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @disposeMethod
  @override
  void dispose() {
    _player.dispose();
  }
}
