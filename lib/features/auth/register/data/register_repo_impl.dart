import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/register_data_source.dart';
import 'package:e_commerce_app/features/auth/register/domain/register_repo.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterDataSource registerDataSource;
  final FirebaseAuth firebaseAuth;

  RegisterRepositoryImpl(this.registerDataSource, this.firebaseAuth);

  @override
  Future<void> saveUser(UserModel user) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    user.id = userCredential.user?.uid ?? '';

    await registerDataSource.saveUser(user);
  }
}
