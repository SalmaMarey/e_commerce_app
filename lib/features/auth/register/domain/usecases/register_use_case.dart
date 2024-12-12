import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/register/domain/user_repo.dart';

class RegisterUseCase {
  final UserRepository userRepository;

  RegisterUseCase(this.userRepository);

  Future<void> call(UserModel user) async {
    await userRepository.saveUser(user);
  }
}
