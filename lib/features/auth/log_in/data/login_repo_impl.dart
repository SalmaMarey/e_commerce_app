import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/log_in/data/remote/login_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/log_in/domain/login_repo.dart';


class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<UserModel> login(String email, String password) async {
    return await loginDataSource.loginUser(email, password);
  }
}
