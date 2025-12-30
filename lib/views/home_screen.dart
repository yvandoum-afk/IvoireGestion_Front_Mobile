import 'package:flutter/material.dart';

import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/more_menu_drawer.dart';
import 'dashboard_screen.dart';
import 'leases_screen.dart';
import 'payments_screen.dart';
import 'property_screen.dart';
import 'tenants_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const DashboardScreen(),
      const PropertyScreen(),
      const TenantsScreen(),
      const LeasesScreen(),
      const PaymentsScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openRightMenu,
        backgroundColor: Colors.white,
        elevation: 0,
        hoverColor: null,
        hoverElevation: 0,
        child: const Icon(Icons.menu),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  void _openRightMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close menu',
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const MoreMenuDrawer();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );
      },
    );
  }
}
