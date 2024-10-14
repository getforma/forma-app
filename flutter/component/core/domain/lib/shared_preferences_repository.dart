abstract class SharedPreferencesRepository {
  dynamic get(String key);

  Future<bool> set<T>(String key, T value);

  Future<bool> remove(String key);
}

enum SharedPreferencesKey {
  currentSession,
}
