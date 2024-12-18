// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/utils/hive_keys.dart';
import 'package:e_commerce_app/features/auth/register/domain/usecases/register_use_case.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_event.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        final isEmailUsed = await _checkEmailExists(event.email);
        print('Email check passed: $isEmailUsed');
        final imageUrl = event.selectedImage != null
            ? await _uploadImage(event.selectedImage!)
            : 'https://cdn-icons-png.flaticon.com/512/3177/3177440.png';
        print('Image uploaded: $imageUrl');
        final user = UserModel(
          id: DateTime.now().toString(),
          email: event.email,
          userName: event.userName,
          password: event.password,
          phoneNumber: event.phoneNumber,
          imageUrl: imageUrl,
        );
        print('User created: ${user.toJson()}');
        await registerUseCase(user);
        print('User registered');
        
        saveUserToHive(user);
        print('User saved to Hive');
        emit(RegisterSuccess());
      } catch (e) {
        print('Error: $e');
        emit(RegisterFailure('Failed to register user: $e'));
      }
    });
  }
  Future<bool> _checkEmailExists(String email) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('e_users')
          .where('email', isEqualTo: email)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check email: $e');
    }
  }

  Future<String> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    final uploadTask = await storageRef.putFile(image);
    return await uploadTask.ref.getDownloadURL();
  }

 void saveUserToHive(UserModel user) {
    try {
      final userBox = Hive.box(HiveKeys.userBox);
      userBox.put('user', user.toJson());
      print('User saved to Hive: ${user.toJson()}');
    } catch (e) {
      print('Failed to save user to Hive: $e');
    }
  }
}