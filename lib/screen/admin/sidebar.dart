import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_state.dart';
import 'helper.dart';

class SidebarPanel extends StatelessWidget {
  const SidebarPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [BoxShadow(blurRadius: 8, offset: Offset(2, 0))],
      ),
      child: const SafeArea(child: _SidebarContent()),
    );
  }
}

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(child: _SidebarContent());
  }
}

class _SidebarContent extends StatelessWidget {
  const _SidebarContent();

  // 🔹 LOGOUT CONFIRM

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AdminState>();
    final isMobile = MediaQuery.of(context).size.width < 1024;

    Widget item(AdminPage page, IconData icon, String label) {
      final active = admin.page == page;

      return ListTile(
        leading: Icon(
          icon,
          color: active ? Theme.of(context).colorScheme.primary : null,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
        selected: active,
        onTap: () {
          context.read<AdminState>().go(page);

          if (isMobile) Navigator.pop(context); // close drawer
        },
      );
    }

    return Column(
      children: [
        // 🔹 HEADER
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                item(
                  AdminPage.dashboard,
                  Icons.dashboard_outlined,
                  'Dashboard',
                ),

                ExpansionTile(
                  leading: const Icon(Icons.people_outline),
                  title: const Text('Users'),
                  childrenPadding: const EdgeInsets.only(left: 16),
                  children: [
                    item(AdminPage.users, Icons.list, 'All Users'),
                    const ListTile(
                      leading: Icon(Icons.security),
                      title: Text('Roles'),
                    ),
                  ],
                ),

                ExpansionTile(
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: const Text('Schedule'),
                  childrenPadding: const EdgeInsets.only(left: 16),
                  children: const [
                    ListTile(
                      leading: Icon(Icons.event),
                      title: Text('Appointments'),
                    ),
                    ListTile(
                      leading: Icon(Icons.date_range),
                      title: Text('Calendar'),
                    ),
                  ],
                ),

                ExpansionTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  childrenPadding: const EdgeInsets.only(left: 16),
                  children: const [
                    ListTile(leading: Icon(Icons.tune), title: Text('General')),
                    ListTile(
                      leading: Icon(Icons.lock_outline),
                      title: Text('Security'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const Divider(height: 1),

        // 🔹 FIXED LOGOUT
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () => confirmLogout(context),
        ),
      ],
    );
  }
}
