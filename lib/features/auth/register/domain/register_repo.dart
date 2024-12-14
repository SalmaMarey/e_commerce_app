import 'package:e_commerce_app/core/models/user_model.dart';

abstract class RegisterRepository {
  Future<void> saveUser(UserModel user);
}