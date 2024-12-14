import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/register_data_source.dart';

class RegisterDataSourceImpl implements RegisterDataSource {
  final FirebaseFirestore firestore;

  RegisterDataSourceImpl(this.firestore);

  @override
  Future<void> saveUser(UserModel user) async {
    await firestore.collection('e_users').doc(user.id).set(user.toJson());
  }
}
