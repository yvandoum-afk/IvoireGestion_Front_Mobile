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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.edit_outlined, size: 64, color: Colors.grey.shade400),
              const Text(
                "Aucune demande trouvée",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              const Text("Aucune demande pour le moment"),
            ],
          ),
        ),
      ),
    );
  }
}
