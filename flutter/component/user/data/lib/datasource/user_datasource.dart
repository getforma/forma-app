import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:user_component_data/user_service.dart';
import 'package:user_component_domain/model/user.dart';

abstract class UserDataSource {
  Future<void> saveUser(User user);

  Future<User?> getCurrentUser();
}

@LazySingleton(as: UserDataSource)
class UserDataSourceImpl implements UserDataSource {
  final UserService _userService;

  UserDataSourceImpl(this._userService);

  @override
  Future<void> saveUser(User user) async {
    final response = await _userService.saveUser(user);
    if (response.response.statusCode == HttpStatus.created) {
      return;
    }
    throw Exception(response.data);
  }

  @override
  Future<User?> getCurrentUser() async {
    // TODO: Implement when backend is ready
    return null;
    // final response = await _userService.getCurrentUser();
    // if (response.response.statusCode == HttpStatus.ok) {
    //   return response.data;
    // }
    // throw Exception(response.data);
  }
}
