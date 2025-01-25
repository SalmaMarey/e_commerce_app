import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/network/internet_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    String errorMessage = 'An unexpected error occurred.';

    if (error is NetworkException) {
      errorMessage = 'Network error: ${error.message}';
    } else if (error is ValidationException) {
      errorMessage = 'Validation error: ${error.message}';
    } else if (error is FirebaseException) {
      errorMessage = 'Firebase error: ${error.message}';
    } else if (error is FormatException) {
      errorMessage = 'Data format error: ${error.message}';
    } else if (error is DioException) {
      errorMessage = 'Network error: ${error.message}';
    } else if (error is String) {
      errorMessage = error;
    } else if (error is Exception) {
      errorMessage = error.toString();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
    debugPrint('Error: $error');
  }
}