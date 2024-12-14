import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:text_to_speech_component_domain/text_to_speech_repository.dart';

@injectable
class GetSpeechFromTextUseCase extends UseCase<String, Unit> {
  final TextToSpeechRepository _textToSpeechRepository;

  GetSpeechFromTextUseCase(this._textToSpeechRepository);

  @override
  Future<Either<Exception, Unit>> invoke(String param) async {
    return _textToSpeechRepository.getSpeechFromText(param);
  }
}
