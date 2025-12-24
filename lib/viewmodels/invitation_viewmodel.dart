import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class InvitationViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  User? _user;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _user;

  // Login method
  Future<bool> invitation(
      String phone, String code, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final result =
          await _authService.invitation(phone, code, email, password);

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
