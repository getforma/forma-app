import 'package:core_component_domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/session_repository.dart';

@injectable
class SpeakTextUseCase implements NotLensUseCase<String, void> {
  final SessionRepository _sessionRepository;

  SpeakTextUseCase(this._sessionRepository);

  @override
  Future<void> invoke(String text) async {
    await _sessionRepository.speakText(text);
  }
}
