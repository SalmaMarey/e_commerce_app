// ignore_for_file: avoid_print

import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_event.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

            // Save user to Hive
            saveUserToHive(userModel);
          } else {
            emit(LoginFailure(
                error: 'User information is not available in Firestore.'));
          }
        } else {
          emit(LoginFailure(error: 'User credentials are null or incomplete.'));
        }
      } catch (e) {
        emit(LoginFailure(
            error: 'An unexpected error occurred: ${e.toString()}'));
      }
    });
  }

  void saveUserToHive(UserModel user) {
    print('Saving user to Hive...');
    final userBox = Hive.box<UserModel>('userBox');
    userBox.put(user.id, user);
    print('User data saved successfully in both Firebase and Hive.');
  }
}
