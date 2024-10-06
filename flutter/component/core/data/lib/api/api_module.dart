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

    dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers["Authorization"] = "Basic YWRtaW46cGFzc3dvcmQ=";
      handler.next(options);
    }));

    return dio;
  }
}
