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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Color(0xFFF97316),
                          child: Text(
                            'JK',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hello  ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Jean Kouassi',
                              style: TextStyle(
                                color: Colors.black,
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
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Documents & Communication section
              _buildDrawerItem(
                context,
                _DrawerItem(
                  Icons.description,
                  'Documents',
                  routeName: '/documents',
                ),
              ),
              _buildDrawerItem(
                context,
                _DrawerItem(
                  Icons.mail,
                  'Messagerie',
                  routeName: '/messaging',
                ),
              ),
              const SizedBox(height: 16),
              // Maintenance & Support section
              _buildDrawerItem(
                context,
                _DrawerItem(
                  Icons.build,
                  'Maintenance',
                  routeName: '/maintenance',
                ),
              ),
              _buildDrawerItem(
                context,
                _DrawerItem(
                  Icons.edit,
                  'Demandes de modification',
                  routeName: '/change-requests',
                ),
              ),
              const SizedBox(height: 16),
              // Évaluations & Notifications section
              _buildDrawerItem(
                context,
                _DrawerItem(
                  Icons.star,
                  'Évaluations',
                  routeName: '/ratings',
                ),
              ),
              _buildDrawerItem(
                context,
                _DrawerItem(
                  Icons.notifications,
                  'Notifications',
                  routeName: '/notifications',
                ),
              ),
              const SizedBox(height: 16),
              // Paramètres section
              _buildDrawerItem(
                context,
                _DrawerItem(
                  Icons.settings,
                  'Paramètres',
                  routeName: '/settings',
                ),
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

  Widget _buildDrawerItem(BuildContext context, _DrawerItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 0,
      color: Colors.grey.withOpacity(0.1),
      child: ListTile(
        leading: Icon(item.icon, color: const Color(0xFFF97316)),
        title: Text(
          item.title,
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFFF97316)),
        onTap: () {
          Navigator.pop(context);
          if (item.routeName != null) {
            Navigator.pushNamed(context, item.routeName!);
          }
        },
      ),
    );
  }
}

class _DrawerItem {
  final IconData icon;
  final String title;
  final String? routeName;

  _DrawerItem(
    this.icon,
    this.title, {
    this.routeName,
  });
}
