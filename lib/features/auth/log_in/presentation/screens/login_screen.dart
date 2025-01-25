// ignore_for_file: avoid_print
import 'package:e_commerce_app/core/error_handler/error_handler.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/controller/login_bloc.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/controller/login_state.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/widgets/login_background_widget.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/login_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<LoginBloc>(),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              print(
                  'LoginSuccess state received. User: ${state.user.toJson()}');
              Navigator.pushReplacementNamed(context, Routes.layout);
            } else if (state is LoginFailure) {
              ErrorHandler.handleError(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              body: SingleChildScrollView(
                child: LoginBackground(
                  child: LoginForm(
                    formKey: formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                    onLoginPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        if (email.isNotEmpty && password.isNotEmpty) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginButtonPressed(
                              email: email,
                              password: password,
                              context: context,
                            ),
                          );
                        } else {
                          ErrorHandler.handleError(
                            context,
                            'Email and password cannot be empty',
                          );
                        }
                      } else {
                        ErrorHandler.handleError(
                          context,
                          'Please fill out all fields correctly',
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
