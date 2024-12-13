import 'package:e_commerce_app/core/models/user_model.dart';

abstract class RegisterDataSource {
  Future<void> saveUser(UserModel user);
}
