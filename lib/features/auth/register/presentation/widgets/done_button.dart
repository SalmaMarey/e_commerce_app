// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/utils/widgets/button_style.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_bloc.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_event.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final File? selectedImage;

  const DoneButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonStyleWidget(
      buttonText: 'Done',
      onPressed: () async {
        if (formKey.currentState?.validate() ?? false) {
          try {
            final imageUrl = selectedImage != null
                ? await _uploadImage(context, selectedImage!)
                : 'https://cdn-icons-png.flaticon.com/512/3177/3177440.png';
            final user = UserModel(
              id: DateTime.now().toString(),
              email: emailController.text,
              password: passwordController.text,
              phoneNumber: phoneController.text,
              imageUrl: imageUrl,
            );
            context.read<UserBloc>().add(SaveUserEvent(user));
              Navigator.pushNamed(context, Routes.home);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to save user: $e')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill all fields correctly')),
          );
        }
      },
    );
  }
  Future<String> _uploadImage(BuildContext context, File image) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = await storageRef.putFile(image);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      Navigator.of(context).pop();
      throw Exception('Failed to upload image: $e');
    }
  }
}
