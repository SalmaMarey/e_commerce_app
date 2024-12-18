import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_event.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/hive_keys.dart';

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
    HiveKeys.userBox;
  }
}
