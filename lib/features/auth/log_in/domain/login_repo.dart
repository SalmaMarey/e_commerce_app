import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class LoginRepository {
  Future<UserModel> login(String email, String password, BuildContext context);
}
