import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFF97316),
        unselectedItemColor: Colors.grey.shade400,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 0 ? Icons.dashboard : Icons.dashboard_outlined,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 1 ? Icons.apartment : Icons.apartment_outlined,
            ),
            label: 'Biens',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 2 ? Icons.people : Icons.people_outlined,
            ),
            label: 'Locataires',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 3
                  ? Icons.description
                  : Icons.description_outlined,
            ),
            label: 'Baux',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 5 ? Icons.payment : Icons.payment_outlined,
            ),
            label: 'Paiements',
          ),
        ],
      ),
    );
  }
}
