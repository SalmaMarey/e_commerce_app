// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/log_in/data/remote/login_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDataSourceImpl implements LoginDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  LoginDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> loginUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot snapshot = await firestore
          .collection('e_users')
          .doc(userCredential.user?.uid)
          .get();

      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User data not found.");
      }
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }
}
