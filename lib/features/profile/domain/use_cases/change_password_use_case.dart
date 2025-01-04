import 'package:e_commerce_app/features/profile/data/remote/profile_remote_data_source.dart';

class ChangePasswordUseCase {
  final ProfileRemoteDataSource remoteDataSource;

  ChangePasswordUseCase(this.remoteDataSource);

  Future<void> call(String currentPassword, String newPassword) async {
    await remoteDataSource.changePassword(currentPassword, newPassword);
  }
}
