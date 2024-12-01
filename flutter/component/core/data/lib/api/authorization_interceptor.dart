import 'package:core_component_domain/secure_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

const String _kAuthorizationKey = "Authorization";
const String _kBearerKeyword = "Bearer";
const List<String> _kExcludedAuthorizationUrls = [];

@injectable
class AuthenticationInterceptor extends Interceptor {
  final Dio dio;

  AuthenticationInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final secureStorage = GetIt.instance.get<SecureStorageRepository>();
    final authToken = await secureStorage.getAccessToken();
    final isExcluded =
        _kExcludedAuthorizationUrls.any((url) => options.path == url);

    if (authToken != null && !isExcluded) {
      options.headers[_kAuthorizationKey] =
          '$_kBearerKeyword ${authToken.token}';
    }

    return handler.next(options);
  }
}
