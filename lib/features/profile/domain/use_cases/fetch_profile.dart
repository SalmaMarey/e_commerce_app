import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/profile/domain/profile_repository.dart';

class FetchProfileUseCase {
  final ProfileRepository repository;

  FetchProfileUseCase(this.repository);

  Future<UserModel> call(String uid) {
    return repository.fetchUserData(uid);
  }
}
