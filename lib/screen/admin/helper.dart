import 'package:flutter/material.dart';

class _SidebarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

        _item(Icons.dashboard_outlined, 'Dashboard'),
        _item(Icons.people_outline, 'Users'),
        _item(Icons.calendar_today_outlined, 'Schedule'),
        _item(Icons.settings_outlined, 'Settings'),

        const Spacer(),

        _item(Icons.logout, 'Logout'),
      ],
    );
  }

  Widget _item(IconData icon, String label) {
    return ListTile(leading: Icon(icon), title: Text(label), onTap: () {});
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
