import 'package:flutter/material.dart';

import 'views/change_requests_screen.dart';
import 'views/documents_screen.dart';
import 'views/home_screen.dart';
import 'views/invitation_screen.dart';
import 'views/login_screen.dart';
import 'views/maintenance_screen.dart';
import 'views/messaging_screen.dart';
import 'views/notifications_screen.dart';
import 'views/ratings_screen.dart';
import 'views/settings_screen.dart';
import 'views/signup_screen.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ivoire Gestion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/invitation': (context) => const InvitationScreen(),
        '/home': (context) => const HomeScreen(),
        '/documents': (context) => const DocumentsScreen(),
        '/messaging': (context) => const MessagingScreen(),
        '/maintenance': (context) => const MaintenanceScreen(),
        '/change-requests': (context) => const ChangeRequestsScreen(),
        '/ratings': (context) => const RatingsScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
