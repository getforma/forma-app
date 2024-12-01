import 'package:core_component_domain/model/auth_token.dart';

abstract class SecureStorageRepository {
  Future<void> setAccessToken(AuthToken accessToken);
  Future<AuthToken?> getAccessToken();
}
