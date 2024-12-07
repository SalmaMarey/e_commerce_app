import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/user_data_source.dart';
import 'package:e_commerce_app/features/auth/register/domain/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl(this.userDataSource);

  @override
  Future<void> saveUser(UserModel user) async {
    await userDataSource.saveUser(user);
  }
}
