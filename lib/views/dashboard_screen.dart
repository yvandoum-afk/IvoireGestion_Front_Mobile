import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [
              //         const Color(0xFFF97316),
              //         const Color(0xFFF97316).withOpacity(0.8),
              //       ],
              //     ),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: const Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Bienvenue',
              //         style: TextStyle(
              //           fontSize: 24,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.white,
              //         ),
              //       ),
              //       SizedBox(height: 8),
              //       Text(
              //         'Voici un aperçu de vos propriétés',
              //         style: TextStyle(
              //           fontSize: 14,
              //           color: Colors.white70,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 24),
              // Statistics section
              const Text(
                'Statistiques',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                'Biens immobiliers',
                '0',
                '',
                Icons.apartment,
                Colors.blue.withOpacity(0.1),
                Colors.blue,
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                'Logements',
                '0',
                '0 occupés • 0 disponibles',
                Icons.home_outlined,
                Colors.green.withOpacity(0.1),
                Colors.green,
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                'Revenus (ce mois)',
                '0 F',
                '',
                Icons.attach_money,
                Colors.orange.withOpacity(0.1),
                Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                'Taux d\'occupations',
                '0%',
                '',
                Icons.show_chart,
                Colors.purple.withOpacity(0.1),
                Colors.purple,
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Paiements récents',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(
                        color: Color(0xFFF97316),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Aucun paiement',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Maintenance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(
                        color: Color(0xFFF97316),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Aucun paiement',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 12),
              _buildStatCard(
                'Revenus nets',
                '0 F',
                'Après commissions',
                Icons.calculate_outlined,
                Colors.green.withOpacity(0.1),
                Colors.green,
              ),

              const SizedBox(height: 12),
              _buildStatCard(
                'Loyers impayés',
                '0',
                'Loyers impayés',
                Icons.error_outline,
                Colors.red.withOpacity(0.1),
                Colors.red,
              ),

              const SizedBox(height: 12),
              _buildStatCard(
                'Loyer moyen',
                '0 F',
                'Par logement',
                Icons.pie_chart_outline,
                Colors.blue.withOpacity(0.1),
                Colors.blue,
              ),

              const SizedBox(height: 12),
              _buildStatCard(
                'Charges',
                '0 F',
                'Maintenance',
                Icons.description_outlined,
                Colors.grey.withOpacity(0.1),
                Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle,
      IconData icon, Color backgroundColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor),
          ),
        ],
      ),
    );
  }
}
