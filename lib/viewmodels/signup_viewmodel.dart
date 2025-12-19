import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  User? _user;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _user;

  // Signup method
  Future<bool> signup(
      String fullname, String email, String phone, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final result =
          await _authService.signup(fullname, email, phone, password);

      if (result['success']) {
        _user = result['user'];
        _setLoading(false);
        return true;
      } else {
        _setError(result['message']);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Erreur de connexion. Veuillez réessayer.');
      _setLoading(false);
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    _setLoading(true);
    await _authService.logout();
    _user = null;
    _setLoading(false);
    _clearError();
  }

  // Check if user is logged in
  Future<bool> checkSignupStatus() async {
    return await _authService.isLoggedIn();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Clear error manually
  void clearError() {
    _clearError();
  }
}
