import 'package:flutter/material.dart';

import '../../helper.dart';

class _SidebarContent extends StatelessWidget {
  @override
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.logout),
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              _logout(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

    showTopToast(
      context,
      message: 'Logged out successfully',
      type: SnackBarType.success,
    );

    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 TOP HEADER
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.admin_panel_settings, size: 40),
              SizedBox(height: 12),
              Text(
                'Admin Panel',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Flutter Web'),
            ],
          ),
        ),

        // 🔹 SCROLLABLE MENU
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _menuItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  onTap: () {},
                ),

                _expandableMenu(
                  context,
                  icon: Icons.people_outline,
                  label: 'Users',
                  children: [
                    _menuItem(context, icon: Icons.list, label: 'All Users'),
                    _menuItem(context, icon: Icons.security, label: 'Roles'),
                  ],
                ),

                _expandableMenu(
                  context,
                  icon: Icons.calendar_today_outlined,
                  label: 'Schedule',
                  children: [
                    _menuItem(
                      context,
                      icon: Icons.event,
                      label: 'Appointments',
                    ),
                    _menuItem(
                      context,
                      icon: Icons.date_range,
                      label: 'Calendar',
                    ),
                  ],
                ),

                _expandableMenu(
                  context,
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  children: [
                    _menuItem(context, icon: Icons.tune, label: 'General'),
                    _menuItem(
                      context,
                      icon: Icons.lock_outline,
                      label: 'Security',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // 🔹 FIXED BOTTOM
        const Divider(height: 1),

        _menuItem(
          context,
          icon: Icons.logout,
          label: 'Logout',
          onTap: () => _confirmLogout(context),
        ),
      ],
    );
  }
}

class SidebarPanel extends StatelessWidget {
  const SidebarPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: SafeArea(child: _SidebarContent()),
    );
  }
}

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: _SidebarContent());
  }
}

Widget _menuItem(
  BuildContext context, {
  required IconData icon,
  required String label,
  VoidCallback? onTap,
}) {
  return ListTile(leading: Icon(icon), title: Text(label), onTap: onTap);
}

Widget _expandableMenu(
  BuildContext context, {
  required IconData icon,
  required String label,
  required List<Widget> children,
}) {
  return ExpansionTile(
    leading: Icon(icon),
    title: Text(label),
    childrenPadding: const EdgeInsets.only(left: 16),
    children: children,
  );
}
