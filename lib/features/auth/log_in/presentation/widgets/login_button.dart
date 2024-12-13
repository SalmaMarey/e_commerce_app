import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_bloc.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          BlocProvider.of<LoginBloc>(context).add(
            LoginButtonPressed(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
          Navigator.pushReplacementNamed(context, Routes.start);
        }
      },
      buttonText: "Done",
    );
  }
}
