import 'package:e_commerce_app/core/network/internet_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    String errorMessage = 'An unexpected error occurred.';

    if (error is NetworkException) {
      errorMessage = 'Network error: Please check your internet connection.';
    } else if (error is ValidationException) {
      errorMessage = 'Validation error: ${error.message}';
    } else if (error is FirebaseException) {
      errorMessage = 'Firebase error: ${error.message}';
    } else if (error is FormatException) {
      errorMessage = 'Data format error: ${error.message}';
    } else if (error is String) {
      errorMessage = error;
    }

    // Show error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );

    // Log the error for debugging
    debugPrint('Error: $error');
  }
}