import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/profile/data/local/profile_local_data_source.dart';
import 'package:e_commerce_app/features/profile/data/remote/profile_remote_data_source.dart';
import 'package:e_commerce_app/features/profile/domain/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<UserModel> fetchUserData(String uid) async {
    try {
      final user = await remoteDataSource.fetchUserData(uid);
      await localDataSource.saveUserData(user);
      return user;
    } catch (e) {
      final user = await localDataSource.fetchUserData(uid);
      if (user != null) return user;
      throw Exception('Unable to fetch user data');
    }
  }

  @override
  Future<void> updateUserData(String uid, UserModel user) async {
    await remoteDataSource.updateUserData(uid, user);
    await localDataSource.saveUserData(user);
  }

  @override
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    await remoteDataSource.changePassword(currentPassword, newPassword);
  }
}
