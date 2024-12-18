import 'dart:io';

import 'package:e_commerce_app/core/models/user_model.dart';

abstract class RegisterEvent {}

class SaveRegisterEvent extends RegisterEvent {
  final UserModel user;

  SaveRegisterEvent(this.user);
}

class RegisterUserEvent extends RegisterEvent {
  final String email;
  final String userName;
  final String password;
  final String phoneNumber;
  final File? selectedImage;

  RegisterUserEvent({
    required this.email,
    required this.userName,
    required this.password,
    required this.phoneNumber,
    this.selectedImage,
  });
}
