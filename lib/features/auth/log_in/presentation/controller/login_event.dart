import 'package:flutter/material.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context; 

  LoginButtonPressed({
    required this.email,
    required this.password,
    required this.context, 
  });
}