import 'dart:convert';

import 'package:core_component_domain/model/auth_token.dart';
import 'package:core_component_domain/secure_storage_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@LazySingleton(as: SecureStorageRepository)
class SecureStorageRepositoryImpl implements SecureStorageRepository {
  static const _accessTokenKey = "accessToken";

  late final FlutterSecureStorage _storage;

  SecureStorageRepositoryImpl() {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  @override
  Future<void> setAccessToken(AuthToken accessToken) async {
    await _storage.write(
        key: _accessTokenKey, value: jsonEncode(accessToken.toJson()));
  }

  @override
  Future<AuthToken?> getAccessToken() async {
    final json = await _storage.read(key: _accessTokenKey);
    return json != null ? AuthToken.fromJson(jsonDecode(json)) : null;
  }
}
