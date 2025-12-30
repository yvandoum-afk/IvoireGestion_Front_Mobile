import 'package:flutter/material.dart';

class ChangeRequestsScreen extends StatelessWidget {
  const ChangeRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Demandes de modification'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('Change Requests Screen'),
      ),
    );
  }
}
