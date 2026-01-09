import 'package:flutter/material.dart';

import '../helper.dart';
import 'widget/content.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin Dashboard'),
        scrolledUnderElevation: 4,
        leading: isDesktop
            ? null
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
      ),

      // ✅ Drawer ONLY on mobile
      drawer: isDesktop ? null : const SidebarDrawer(),

      body: Row(
        children: [
          // ✅ Sidebar panel on desktop
          if (isDesktop) const SidebarPanel(),

          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: DashboardContent(),
            ),
          ),
        ],
      ),
    );
  }
}
