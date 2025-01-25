// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error_handler/error_handler.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/network/internet_checker.dart';
import 'package:e_commerce_app/features/auth/log_in/data/remote/login_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class LoginDataSourceImpl implements LoginDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  LoginDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> loginUser(
      String email, String password, BuildContext context) async {
    try {
      final internetChecker = InternetChecker(InternetConnection());
      final isConnected = await internetChecker.isConnected;

      if (!isConnected) {
        throw NetworkException('No internet connection.');
      }
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      DocumentSnapshot snapshot = await firestore
          .collection('e_users')
          .doc(userCredential.user?.uid)
          .get();

      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User data not found.");
      }
    } on FirebaseAuthException catch (e) {
      ErrorHandler.handleError(
          context,
          FirebaseException(
              message: e.message ?? 'Firebase authentication failed.',
              plugin: ''));
      throw NetworkException('Firebase authentication error: ${e.message}');
    } on FirebaseException catch (e) {
      ErrorHandler.handleError(context, e);
      throw NetworkException('Firebase error: ${e.message}');
    } on FormatException catch (e) {
      ErrorHandler.handleError(context, e);
      throw ValidationException('Data format error: ${e.message}');
    } catch (e) {
      ErrorHandler.handleError(context, e);
      throw Exception('Login failed: ${e.toString()}');
    }
  }
}
