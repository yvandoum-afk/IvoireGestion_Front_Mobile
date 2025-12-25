import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plus'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          const _SectionHeader('Gestion Financière'),
          _buildMenuItem(
            context,
            Icons.payment,
            'Paiements et facturation',
            'Gérez vos paiements',
            () {},
          ),
          const SizedBox(height: 12),
          const _SectionHeader('Documents & Communication'),
          _buildMenuItem(
            context,
            Icons.description,
            'Documents',
            'Stockez vos documents',
            () {},
          ),
          _buildMenuItem(
            context,
            Icons.mail,
            'Messagerie',
            'Communiquez avec les locataires',
            () {},
          ),
          const SizedBox(height: 12),
          const _SectionHeader('Maintenance & Support'),
          _buildMenuItem(
            context,
            Icons.build,
            'Maintenance',
            'Signalez des problèmes',
            () {},
          ),
          _buildMenuItem(
            context,
            Icons.edit,
            'Demandes de modification',
            'Gérez les demandes',
            () {},
          ),
          const SizedBox(height: 12),
          const _SectionHeader('Évaluations & Notifications'),
          _buildMenuItem(
            context,
            Icons.star,
            'Évaluations',
            'Consultez les avis',
            () {},
          ),
          _buildMenuItem(
            context,
            Icons.notifications,
            'Notifications',
            'Gérez vos alertes',
            () {},
          ),
          const SizedBox(height: 12),
          const _SectionHeader('Paramètres'),
          _buildMenuItem(
            context,
            Icons.settings,
            'Paramètres',
            'Configurez votre compte',
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF97316).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFF97316),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFFF97316),
        ),
      ),
    );
  }
}
