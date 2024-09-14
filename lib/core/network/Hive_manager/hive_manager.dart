import 'package:hive_flutter/hive_flutter.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../Features/authentication_feature/data/user_model/user_model.dart';
import 'hive_boxes_names.dart';
import 'hive_helper.dart';

class HiveManager implements LocalStorageManager {
  static final Map<String, Box<dynamic>> _openedBoxes = {};

  @override
  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(VideoEntityAdapter());
    Hive.registerAdapter(UserEntityAdapter());

    await _openAllBoxes();
  }

  Future<void> _openAllBoxes() async {
    await Future.wait([
      _openBox<VideoEntity>(HiveBoxesNames.kVideoBox),
      _openBox<UserModel>(HiveBoxesNames.kUserBox),
      _openBox<String>(
          HiveBoxesNames.kSaveTokenBox), // Assuming SaveTokenBox stores Strings
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
