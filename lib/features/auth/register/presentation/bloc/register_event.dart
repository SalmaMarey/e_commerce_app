import 'package:e_commerce_app/core/models/user_model.dart';



abstract class RegisterEvent {}

class SaveRegisterEvent extends RegisterEvent {
  final UserModel user;

  SaveRegisterEvent(this.user);
}
