abstract class LocalStorageManager {
  const LocalStorageManager._();
  Future<void> initialize();
  Future<void> saveData<T>(List<T> data, String boxName);
  Future<List<T>> loadData<T>(String boxName);
  Future<void> saveSingleItem<T>(String key, T item, String boxName);
  Future<T?> loadSingleItem<T>(String key, String boxName);
  Future<void> clearData<T>(String boxName);
  Future<void> clearSingleItem<T>(String key, String boxName);
}
