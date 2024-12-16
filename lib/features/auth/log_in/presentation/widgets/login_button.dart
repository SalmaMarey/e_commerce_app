// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () async {
        if (formKey.currentState?.validate() ?? false) {
          try {
            UserCredential userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            if (userCredential.user != null) {
              Navigator.pushReplacementNamed(context, Routes.layout);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Invalid email or password. Please try again.')),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Authentication failed. Please check your credentials and try again.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please fill out all fields correctly')),
          );
        }
      },
      buttonText: "Done",
    );
  }
}
