// ignore_for_file: avoid_print

import 'package:e_commerce_app/core/error_handler/error_handler.dart';
import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/controller/login_event.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/controller/login_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final FirebaseFirestore firestore;

  LoginBloc({
    required this.loginUseCase,
    required this.firestore,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        if (userCredential.user != null) {
          DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore
              .collection('e_users')
              .doc(userCredential.user!.uid)
              .get();

          if (userDoc.exists) {
            final userModel = UserModel.fromJson(userDoc.data()!);
            emit(LoginSuccess(user: userModel));
            saveUserToHive(userModel, event.context);
          } else {
            emit(LoginFailure(
                error: 'User information is not available in Firestore.'));
            ErrorHandler.handleError(event.context,
                'User information is not available in Firestore.');
          }
        } else {
          emit(LoginFailure(error: 'User credentials are null or incomplete.'));
          ErrorHandler.handleError(
              event.context, 'User credentials are null or incomplete.');
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password, please try again.';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'User not found, please check your email.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email address.';
        } else {
          errorMessage = 'Login failed: ${e.message}';
        }
        emit(LoginFailure(error: errorMessage));
        ErrorHandler.handleError(event.context, errorMessage);
      } catch (e) {
        final errorMessage = 'An unexpected error occurred: ${e.toString()}';
        emit(LoginFailure(error: errorMessage));
        ErrorHandler.handleError(event.context, errorMessage);
      }
    });
  }
  void saveUserToHive(UserModel user, BuildContext context) async {
    try {
      print('Saving user to Hive...');
      final userBox = Hive.box<UserModel>('userBox');
      userBox.put(user.id, user);
      await Hive.openBox<Product>('favoritesBox_${user.id}');
      await Hive.openBox<Cart>('cartBox_${user.id}');
      print('User data saved successfully in both Firebase and Hive.');
    } catch (e) {
      print('Error saving user to Hive: $e');
      ErrorHandler.handleError(context, 'Error saving user data to Hive.');
    }
  }
}
