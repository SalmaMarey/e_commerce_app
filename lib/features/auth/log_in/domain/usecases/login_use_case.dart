import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error_handler/error_handler.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/network/internet_checker.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<UserModel> call(String email, String password, BuildContext context) async {
    try {
      final user = await loginRepository.login(email, password, context);
      return user;
    } on NetworkException catch (e) {
      ErrorHandler.handleError(context, e);
      rethrow; 
    } on ValidationException catch (e) {
      ErrorHandler.handleError(context, e);
      rethrow;
    } on FirebaseException catch (e) {
      ErrorHandler.handleError(context, e);
      throw NetworkException('Firebase error: ${e.message}');
    } catch (e) {
      ErrorHandler.handleError(context, e);
      throw Exception('Login failed: ${e.toString()}');
    }
  }
}