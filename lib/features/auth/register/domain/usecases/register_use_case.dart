import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/network/internet_checker.dart';
import 'package:e_commerce_app/features/auth/register/domain/register_repo.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase(this.registerRepository);

  Future<void> call(UserModel user) async {
    try {
      await registerRepository.saveUser(user);
    } on NetworkException catch (e) {
      throw NetworkException(e.message);
    } on Exception catch (e) {
      throw NetworkException('An unexpected error occurred: ${e.toString()}');
    }
  }
}