import 'package:e_commerce_app/core/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class PasswordChangeSuccess extends ProfileState {
  final String message;

  PasswordChangeSuccess(this.message);
}
