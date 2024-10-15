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
  T? get<T>(SharedPreferencesKey key) {
    final value = _sharedPreferences.get(key.toString()) as T?;
    return value;
  }

  @override
  Future<bool> set<T>(SharedPreferencesKey key, T value) async {
    final _key = key.toString();
    bool result;
    if (value is String) {
      result = await _sharedPreferences.setString(_key, value);
    } else if (value is int) {
      result = await _sharedPreferences.setInt(_key, value);
    } else if (value is double) {
      result = await _sharedPreferences.setDouble(_key, value);
    } else if (value is bool) {
      result = await _sharedPreferences.setBool(_key, value);
    } else if (value is List<String>) {
      result = await _sharedPreferences.setStringList(_key, value);
    } else {
      return false;
    }
    return result;
  }

  @override
  Future<bool> remove(SharedPreferencesKey key) async {
    final result = await _sharedPreferences.remove(key.toString());
    return result;
  }
}
