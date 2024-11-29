import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetChecker {
  final InternetConnection _connectionChecker;

  const InternetChecker(this._connectionChecker);

  Future<bool> get isConnected async =>
      await _connectionChecker.hasInternetAccess;
}
