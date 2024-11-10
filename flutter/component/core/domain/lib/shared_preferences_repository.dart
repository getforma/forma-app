abstract class SharedPreferencesRepository {
  T? get<T>(SharedPreferencesKey key);

  Future<bool> set<T>(SharedPreferencesKey key, T value);

  Future<bool> remove(SharedPreferencesKey key);
}

enum SharedPreferencesKey {
  first,
}
