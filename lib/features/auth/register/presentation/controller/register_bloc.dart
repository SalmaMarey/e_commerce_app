// ignore_for_file: avoid_print

import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/network/internet_checker.dart';
import 'package:e_commerce_app/features/auth/register/domain/usecases/register_use_case.dart';
import 'package:e_commerce_app/features/auth/register/presentation/controller/register_event.dart';
import 'package:e_commerce_app/features/auth/register/presentation/controller/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<SaveRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        await registerUseCase(event.user);
        await saveUserToHive(event.user);
        emit(RegisterSuccess());
      } on NetworkException catch (e) {
        emit(RegisterFailure('Network error: ${e.message}'));
      } on HiveError catch (e) {
        emit(RegisterFailure('Local storage error: ${e.message}'));
      } on Exception catch (e) {
        emit(RegisterFailure('An unexpected error occurred: ${e.toString()}'));
      }
    });
  }

  Future<void> saveUserToHive(UserModel user) async {
    try {
      print('Saving user to Hive...');
      final userBox = await Hive.openBox<UserModel>('userBox');
      await userBox.clear();
      await userBox.put(user.id, user);
      print('User data saved successfully in Hive.');
    } on HiveError catch (e) {
      print('Failed to save user in Hive: $e');
      throw HiveError('Failed to save user in Hive: ${e.message}');
    } on Exception catch (e) {
      print('Failed to save user in Hive: $e');
      throw Exception('Failed to save user in Hive: ${e.toString()}');
    }
  }
}