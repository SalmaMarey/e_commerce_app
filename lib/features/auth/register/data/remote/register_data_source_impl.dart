import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/network/internet_checker.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/register_data_source.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class RegisterDataSourceImpl implements RegisterDataSource {
  final FirebaseFirestore firestore;

  RegisterDataSourceImpl(this.firestore);

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final internetChecker = InternetChecker(InternetConnection());
      final isConnected = await internetChecker.isConnected;

      if (!isConnected) {
        throw NetworkException('No internet connection.');
      }
      await firestore.collection('e_users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw NetworkException('Firestore error: ${e.message}');
    } on FormatException catch (e) {
      throw ValidationException('Invalid data format: ${e.message}');
    } on Exception catch (e) {
      throw NetworkException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
