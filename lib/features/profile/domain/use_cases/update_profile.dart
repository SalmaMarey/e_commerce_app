import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/profile/domain/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(String uid, UserModel user) {
    return repository.updateUserData(uid, user);
  }
}
