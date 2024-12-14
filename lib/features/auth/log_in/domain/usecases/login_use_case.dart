import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/login_repo.dart';


class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<UserModel> call(String email, String password) {
    return loginRepository.login(email, password);
  }
}
