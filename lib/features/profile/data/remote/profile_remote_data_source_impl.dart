import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ProfileRemoteDataSourceImpl(this.firestore, this.auth);

  @override
  Future<UserModel> fetchUserData(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      throw Exception('User not found');
    }
    return UserModel.fromJson(doc.data()!);
  }

  @override
  Future<void> updateUserData(String uid, UserModel user) async {
    await firestore.collection('users').doc(uid).update(user.toJson());
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    final user = auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          throw Exception("The current password is incorrect.");
        }
      }
      throw Exception("Failed to change password: ${e.toString()}");
    }
  }
}