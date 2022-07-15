abstract class LocalStorageAdapter {
  Future<void> saveData<T>({required List<String> data, required String key});
  Future<List<String>> getData(String key);
}
