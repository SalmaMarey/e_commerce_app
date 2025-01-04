import 'package:e_commerce_app/core/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> fetchUserData(String uid);
  Future<void> updateUserData(String uid, UserModel user);
  Future<void> changePassword(String currentPassword, String newPassword);
}
