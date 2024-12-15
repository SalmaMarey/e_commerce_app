import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_event.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final FirebaseAuth firebaseAuth;

  LoginBloc({
    required this.loginUseCase,
    required this.firebaseAuth,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        if (userCredential.user != null) {
          final userModel = UserModel.fromJson({
            'id': userCredential.user!.uid,
            'email': userCredential.user!.email,
            'phoneNumber': userCredential.user!.phoneNumber ?? '',
            'imageUrl': userCredential.user!.photoURL ?? '',
          });
          emit(LoginSuccess(user: userModel));
        } else {
          emit(LoginFailure(error: 'User information is null or incomplete.'));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(LoginFailure(error: 'No user found with this email. Please register first.'));
        } else if (e.code == 'wrong-password') {
          emit(LoginFailure(error: 'Incorrect password. Please try again.'));
        } else {
          emit(LoginFailure(error: 'Login failed: ${e.message}'));
        }
      } catch (e) {
        emit(LoginFailure(error: 'An unexpected error occurred: ${e.toString()}'));
      }
    });
  } void saveUserToHive(UserModel user) {
    final userBox = Hive.box<UserModel>('userBox');
    userBox.put('user_id', user);
  }
}
