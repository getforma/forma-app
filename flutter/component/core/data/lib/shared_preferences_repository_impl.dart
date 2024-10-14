import 'package:core_component_domain/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SharedPreferencesRepository)
class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  late final SharedPreferences _sharedPreferences;

  SharedPreferencesRepositoryImpl() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  @override
  dynamic get(String key) {
    final value = _sharedPreferences.get(key);
    return value;
  }

  @override
  Future<bool> set<T>(String key, T value) async {
    bool result;
    if (value is String) {
      result = await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      result = await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      result = await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      result = await _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      result = await _sharedPreferences.setStringList(key, value);
    } else {
      return false;
    }
    return result;
  }

  @override
  Future<bool> remove(String key) async {
    final result = await _sharedPreferences.remove(key);
    return result;
  }
}
