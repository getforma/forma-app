import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:user_component_domain/model/user.dart';

part 'user_service.g.dart';

@RestApi()
@lazySingleton
abstract class UserService {
  @factoryMethod
  factory UserService(Dio dio) = _UserService;

  @POST("/users")
  Future<HttpResponse> saveUser(@Body() User body);
}
