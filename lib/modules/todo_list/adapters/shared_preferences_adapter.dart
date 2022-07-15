import 'dart:convert';

import 'package:decorator_pattern_flutter/modules/todo_list/adapters/local_storage_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAdapter implements LocalStorageAdapter {
  @override
  Future<void> saveData<T>({
    required List<String> data,
    required String key,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setStringList(
      'todos',
      data,
    );
  }

  @override
  Future<List<String>> getData(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedData = sharedPreferences.getStringList('todos');

    if (cachedData == null) {
      return [];
    }

    final List<String> decodedData = [];

    cachedData.map((data) {
      decodedData.add(jsonDecode(data));
    }).toList();

    print('Cashed Data: ${decodedData.length}');

    return decodedData;
  }
}
