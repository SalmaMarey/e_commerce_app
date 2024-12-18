import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveKeys {
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>('userBox');
  }

  static const String userBox = 'user_box';
  static const String userNameKey = 'user_name';
  static const String userEmailKey = 'user_email';
  static const String isLoggedInKey = 'is_logged_in';
  static const String userPreferencesKey = 'user_preferences';
}
