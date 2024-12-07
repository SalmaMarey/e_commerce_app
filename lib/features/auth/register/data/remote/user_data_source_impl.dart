import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/user_data_source.dart';


class UserDataSourceImpl implements UserDataSource {
  final FirebaseFirestore firestore;

  UserDataSourceImpl(this.firestore);

  @override
  Future<void> saveUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }
}
