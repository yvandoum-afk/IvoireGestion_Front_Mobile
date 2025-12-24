enum UserRole { admin, technicien, observateur }

class User {
  final int id;
  final String email;
  final String passwordHash;
  final String firstName;
  final String lastName;
  final UserRole role;
  final String? phone;
  final bool isActive;
  final DateTime? lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.phone,
    this.isActive = true,
    this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
  });

  // Helper getters for UI display
  String get fullName => '$firstName $lastName';
  String get displayRole {
    switch (role) {
      case UserRole.admin:
        return 'Administrateur';
      case UserRole.technicien:
        return 'Technicien';
      case UserRole.observateur:
        return 'Observateur';
    }
  }

  // Legacy getters for backward compatibility (if needed)
  String get name => lastName;
  String? get location => null; // Will be added when available
  bool get hasProfileImage => false; // No image field in Prisma schema

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      passwordHash: json['password_hash'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      role: _parseUserRole(json['role']),
      phone: json['phone'],
      isActive: json['is_active'] ?? true,
      lastLogin: json['last_login'] != null
          ? DateTime.tryParse(json['last_login'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  static UserRole _parseUserRole(String? roleString) {
    switch (roleString) {
      case 'admin':
        return UserRole.admin;
      case 'technicien':
        return UserRole.technicien;
      case 'observateur':
      default:
        return UserRole.observateur;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password_hash': passwordHash,
      'first_name': firstName,
      'last_name': lastName,
      'role': role.name,
      'phone': phone,
      'is_active': isActive,
      'last_login': lastLogin?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
