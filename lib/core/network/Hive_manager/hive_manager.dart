import 'package:hive_flutter/hive_flutter.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../Features/favourites_feature/domain/favourite_entitiy.dart';
import 'hive_boxes_names.dart';
import 'hive_helper.dart';

class HiveManager implements LocalStorageManager {
  static final Map<String, Box<dynamic>> _openedBoxes = {};

  @override
  Future<void> initialize() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(VideoEntityAdapter());
      Hive.registerAdapter(UserEntityAdapter());
      Hive.registerAdapter(FavouritesEntityAdapter());

      await _openAllBoxes();
    } catch (e) {
      print('Failed to initialize Hive: $e');
      rethrow;
    }
  }

  Future<void> _openAllBoxes() async {
    try {
      await Future.wait([
        _openBox<VideoEntity>(HiveBoxesNames.kVideoBox),
        _openBox<UserEntity>(HiveBoxesNames.kUserBox),
        _openBox<String>(HiveBoxesNames.kSaveTokenBox),
        _openBox<FavouritesEntity>(HiveBoxesNames.kFavouritesBox),
      ]);
    } catch (e) {
      print('Failed to open all boxes: $e');
      rethrow;
    }
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
    try {
      var box = _getBox<T>(boxName);
      await box.clear();
      await box.addAll(data);
    } catch (e) {
      print('Failed to save data to $boxName: $e');
      rethrow;
    }
  }

  @override
  Future<List<T>> loadData<T>(String boxName) async {
    try {
      var box = _getBox<T>(boxName);
      return box.values.toList();
    } catch (e) {
      print('Failed to load data from $boxName: $e');
      rethrow;
    }
  }

  @override
  Future<void> saveSingleItem<T>(String key, T item, String boxName) async {
    try {
      var box = _getBox<T>(boxName);
      await box.put(key, item);
    } catch (e) {
      print('Failed to save single item to $boxName: $e');
      rethrow;
    }
  }

  @override
  Future<T?> loadSingleItem<T>(String key, String boxName) async {
    try {
      var box = _getBox<T>(boxName);
      return box.get(key);
    } catch (e) {
      print('Failed to load single item from $boxName: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearData<T>(String boxName) async {
    try {
      var box = _getBox<T>(boxName);
      await box.clear();
    } catch (e) {
      print('Failed to clear data from $boxName: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearSingleItem<T>(String key, String boxName) async {
    try {
      var box = _getBox<T>(boxName);
      await box.delete(key);
    } catch (e) {
      print('Failed to clear single item from $boxName: $e');
      rethrow;
    }
  }
}
