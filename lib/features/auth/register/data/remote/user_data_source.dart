import 'package:e_commerce_app/core/models/user_model.dart';

abstract class UserDataSource {
  Future<void> saveUser(UserModel user);
}
