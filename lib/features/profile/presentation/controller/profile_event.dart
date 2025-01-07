import 'package:e_commerce_app/core/models/user_model.dart';

abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {
  final String uid;

  FetchProfileEvent(this.uid);
}

class UpdateProfileEvent extends ProfileEvent {
  final UserModel user;

  UpdateProfileEvent(this.user);
}

class ChangePassword extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  ChangePassword(this.currentPassword, this.newPassword);
}
