import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:core_component_domain/model/auth_token.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAccessTokenUseCase implements NotLensUseCase<EmptyParam, AuthToken?> {
  final AuthenticationRepository _authenticationRepository;

  GetAccessTokenUseCase(this._authenticationRepository);

  @override
  Future<AuthToken?> invoke(EmptyParam param) async {
    return _authenticationRepository.getAccessToken();
  }
}
