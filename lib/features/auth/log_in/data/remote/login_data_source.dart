import 'package:e_commerce_app/core/models/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> loginUser(String email, String password);
}