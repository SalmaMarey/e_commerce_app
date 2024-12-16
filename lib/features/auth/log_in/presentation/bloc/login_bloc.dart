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
    print('Starting Firebase login...');
    UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    print('Login response received.');
    if (userCredential.user != null) {
      print('Firebase login successful. User UID: ${userCredential.user!.uid}');
      final userModel = UserModel.fromJson({
        'id': userCredential.user!.uid,
        'email': userCredential.user!.email!,
        'phoneNumber': userCredential.user!.phoneNumber ?? '',
        'imageUrl': userCredential.user!.photoURL ?? '',
        'userName': userCredential.user!.displayName ?? '',
      });

      print('User model created: ${userModel.toJson()}');
      print('About to save user to Hive...');
      
      emit(LoginSuccess(user: userModel));
      saveUserToHive(userModel);
    } else {
      print('Firebase returned null for user credentials.');
      emit(LoginFailure(error: 'User information is null or incomplete.'));
    }
  } catch (e) {
    print('Login failed with error: ${e.toString()}');
    emit(LoginFailure(error: 'An unexpected error occurred: ${e.toString()}'));
  }
});}

void saveUserToHive(UserModel user) {
  print('Saving user to Hive...');
  final userBox = Hive.box<UserModel>('userBox');
  userBox.put('user_id', user);
  print('User data saved in Hive.');
  print('User data saved successfully in both Firebase and Hive.');
}
}