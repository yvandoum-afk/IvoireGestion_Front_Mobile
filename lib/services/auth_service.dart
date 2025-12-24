import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'api_endpoint.dart';
import 'token_manager.dart';

class AuthService {
  final TokenManager _tokenManager = TokenManager();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoint.baseUrl}/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Login successful
        final token = responseData['data']['token'];
        final userData = responseData['data']['user'];

        if (token != null) {
          // Save token
          await _tokenManager.saveToken(token);
        }

        return {
          'success': true,
          'user': User.fromJson(userData),
          'token': token,
          'message': responseData['message'] ?? 'Connexion réussie',
        };
      } else {
        // Login failed
        return {
          'success': false,
          'message': responseData['message'] ?? 'Erreur de connexion',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion. Vérifiez votre connexion internet.',
      };
    }
  }

  Future<Map<String, dynamic>> signup(
      String fullname, String email, String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoint.baseUrl}/user/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullname': fullname,
          'email': email,
          'phone': phone,
          'password': password
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Signup successful
        final token = responseData['data']['token'];
        final userData = responseData['data']['user'];

        if (token != null) {
          // Save token
          await _tokenManager.saveToken(token);
        }

        return {
          'success': true,
          'user': User.fromJson(userData),
          'token': token,
          'message': responseData['message'] ?? 'Inscription réussie',
        };
      } else {
        // Signup failed
        return {
          'success': false,
          'message': responseData['message'] ?? 'Erreur d\'inscription',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion. Vérifiez votre connexion internet.',
      };
    }
  }

  Future<Map<String, dynamic>> invitation(
      String phone, String code, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoint.baseUrl}/user/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phone,
          'code': code,
          'email': email,
          'password': password
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Signup successful
        final token = responseData['data']['token'];
        final userData = responseData['data']['user'];

        if (token != null) {
          // Save token
          await _tokenManager.saveToken(token);
        }

        return {
          'success': true,
          'user': User.fromJson(userData),
          'token': token,
          'message': responseData['message'] ?? 'Inscription réussie',
        };
      } else {
        // Signup failed
        return {
          'success': false,
          'message': responseData['message'] ?? 'Erreur d\'inscription',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion. Vérifiez votre connexion internet.',
      };
    }
  }

  Future<bool> logout() async {
    try {
      // Delete local token
      await _tokenManager.deleteToken();
      return true;
    } catch (e) {
      // Even if deletion fails, return true as user intent is to logout
      return true;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _tokenManager.getToken();
    return token != null;
  }

  Future<String?> getToken() async {
    return await _tokenManager.getToken();
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final token = await _tokenManager.getToken();

      if (token == null) {
        return {'success': false, 'message': 'Non authentifié'};
      }

      final response = await http.get(
        Uri.parse('${ApiEndpoint.baseUrl}/api/agent/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == true) {
        final userData = responseData['data'];

        return {
          'success': true,
          'user': User.fromJson(userData),
          'message': responseData['message'] ?? 'Profil récupéré',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ??
              'Erreur lors de la récupération du profil',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion. Vérifiez votre connexion internet.',
      };
    }
  }
}
