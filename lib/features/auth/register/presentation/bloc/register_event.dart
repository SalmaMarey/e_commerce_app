import 'package:e_commerce_app/core/models/user_model.dart';



abstract class UserEvent {}

class SaveUserEvent extends UserEvent {
  final UserModel user;

  SaveUserEvent(this.user);
}
