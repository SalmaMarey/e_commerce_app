import 'package:e_commerce_app/core/models/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> login(String email, String password);
}
