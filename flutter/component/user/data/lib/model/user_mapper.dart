import 'package:core_component_data/database/app_database.dart';
import 'package:user_component_domain/model/user.dart';

extension UserTableDataMapper on UserTableData {
  User toUser() {
    return User(
      email: email,
      name: name,
    );
  }
}
