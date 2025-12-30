import 'package:flutter/material.dart';

class MoreMenuDrawer extends StatelessWidget {
  const MoreMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Header with close button and profile
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF97316),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white,
                          child: Text(
                            'JK',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF97316),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Jean Kouassi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildDrawerSection(
                'Gestion Financière',
                [
                  _DrawerItem(
                    Icons.payment,
                    'Paiements et facturation',
                    'Gérez vos paiements',
                  ),
                ],
              ),
              _buildDrawerSection(
                'Documents & Communication',
                [
                  _DrawerItem(
                    Icons.description,
                    'Documents',
                    'Stockez vos documents',
                  ),
                  _DrawerItem(
                    Icons.mail,
                    'Messagerie',
                    'Communiquez avec les locataires',
                  ),
                ],
              ),
              _buildDrawerSection(
                'Maintenance & Support',
                [
                  _DrawerItem(
                    Icons.build,
                    'Maintenance',
                    'Signalez des problèmes',
                  ),
                  _DrawerItem(
                    Icons.edit,
                    'Demandes de modification',
                    'Gérez les demandes',
                  ),
                ],
              ),
              _buildDrawerSection(
                'Évaluations & Notifications',
                [
                  _DrawerItem(
                    Icons.star,
                    'Évaluations',
                    'Consultez les avis',
                  ),
                  _DrawerItem(
                    Icons.notifications,
                    'Notifications',
                    'Gérez vos alertes',
                  ),
                ],
              ),
              _buildDrawerSection(
                'Paramètres',
                [
                  _DrawerItem(
                    Icons.settings,
                    'Paramètres',
                    'Configurez votre compte',
                  ),
                ],
              ),
              const Divider(height: 32),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Déconnexion',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerSection(String title, List<_DrawerItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF97316),
            ),
          ),
        ),
        ...items.map((item) => _buildDrawerItem(item)),
      ],
    );
  }

  Widget _buildDrawerItem(_DrawerItem item) {
    return ListTile(
      leading: Icon(item.icon, color: const Color(0xFFF97316)),
      title: Text(
        item.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        item.subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      onTap: () {
        // Handle navigation
      },
    );
  }
}

class _DrawerItem {
  final IconData icon;
  final String title;
  final String subtitle;

  _DrawerItem(this.icon, this.title, this.subtitle);
}
