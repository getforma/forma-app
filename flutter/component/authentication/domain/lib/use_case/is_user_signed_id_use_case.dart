import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsUserSignedInUseCase implements NotLensUseCase<EmptyParam, bool> {
  final AuthenticationRepository _authenticationRepository;

  IsUserSignedInUseCase(this._authenticationRepository);

  @override
  Future<bool> invoke(EmptyParam param) async {
    return _authenticationRepository.isUserSignedIn();
  }
}
