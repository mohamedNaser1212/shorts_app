import 'package:hive_flutter/hive_flutter.dart';

import 'hive_helper.dart';

class HiveManager implements LocalStorageManager {
  static final Map<String, Box<dynamic>> _openedBoxes = {};

  @override
  Future<void> initialize() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(ProductEntityAdapter());
    // Hive.registerAdapter(CategoriesEntityAdapter());
    // Hive.registerAdapter(FavouritesEntityAdapter());
    // Hive.registerAdapter(AddToCartEntityAdapter());
    // Hive.registerAdapter(UserEntityAdapter());
    await _openAllBoxes();
  }

  Future<void> _openAllBoxes() async {
    await Future.wait([
      // _openBox<ProductEntity>(HiveBoxesNames.kProductsBox),
      // _openBox<CategoriesEntity>(HiveBoxesNames.kCategoriesBox),
      // _openBox<FavouritesEntity>(HiveBoxesNames.kFavouritesBox),
      // _openBox<CartEntity>(HiveBoxesNames.kCartBox),
      // _openBox<UserEntity>(HiveBoxesNames.kUserBox),
      // _openBox<String>(HiveBoxesNames.kSaveTokenBox),
    ]);
  }

  Future<void> _openBox<T>(String boxName) async {
    try {
      if (!_openedBoxes.containsKey(boxName)) {
        final box = await Hive.openBox<T>(boxName);
        _openedBoxes[boxName] = box;
      }
    } catch (e) {
      print('Failed to open box $boxName: $e');
      throw Exception("Box $boxName could not be opened.");
    }
  }

  Box<T> _getBox<T>(String boxName) {
    final box = _openedBoxes[boxName] as Box<T>?;
    if (box == null) {
      throw Exception("Box $boxName is not opened.");
    }
    return box;
  }

  @override
  Future<void> saveData<T>(List<T> data, String boxName) async {
    var box = _getBox<T>(boxName);
    await box.clear();
    await box.addAll(data);
  }

  @override
  Future<List<T>> loadData<T>(String boxName) async {
    var box = _getBox<T>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> saveSingleItem<T>(String key, T item, String boxName) async {
    var box = _getBox<T>(boxName);
    await box.put(key, item);
  }

  @override
  Future<T?> loadSingleItem<T>(String key, String boxName) async {
    var box = _getBox<T>(boxName);
    return box.get(key);
  }

  @override
  Future<void> clearData<T>(String boxName) async {
    var box = _getBox<T>(boxName);
    await box.clear();
  }

  @override
  Future<void> clearSingleItem<T>(String key, String boxName) async {
    var box = _getBox<T>(boxName);
    await box.delete(key);
  }
}
