import 'package:core_component_data/api/authorization_interceptor.dart';
import 'package:core_component_data/api/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule {
  @lazySingleton
  Dio dio(
    @Named(namedApiUrl) String baseUrl,
  ) {
    Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
    dio.interceptors.add(AuthenticationInterceptor(dio));

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
    }

    return dio;
  }
}
