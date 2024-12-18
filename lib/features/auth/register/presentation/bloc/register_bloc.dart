// ignore_for_file: avoid_print

import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/register/domain/usecases/register_use_case.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_event.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_state.dart';
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
      } catch (e) {
        emit(RegisterFailure(e.toString()));
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
    } catch (e) {
      print('Failed to save user in Hive: $e');
    }
  }
}
