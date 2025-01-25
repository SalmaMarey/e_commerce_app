import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class LoginDataSource {
  Future<UserModel> loginUser(String email, String password, BuildContext context);
}