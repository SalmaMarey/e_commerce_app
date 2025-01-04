import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:hive/hive.dart';

class ProfileLocalDataSource {
  Future<UserModel?> fetchUserData(String uid) async {
    final box = await Hive.openBox<UserModel>('userBox');
    return box.get(uid);
  }

  Future<void> saveUserData(UserModel user) async {
    final box = await Hive.openBox<UserModel>('userBox');
    await box.put(user.id, user);
  }
}
