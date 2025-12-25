import 'package:flutter/material.dart';

import '../widgets/custom_bottom_nav_bar.dart';
import 'dashboard_screen.dart';
import 'leases_screen.dart';
import 'more_screen.dart';
import 'property_screen.dart';
import 'tenants_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const DashboardScreen(),
      const PropertyScreen(),
      const TenantsScreen(),
      const LeasesScreen(),
      const MoreScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
