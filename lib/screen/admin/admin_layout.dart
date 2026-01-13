import 'package:flutter/material.dart';
import 'package:jadwal_dokter/screen/admin/master/poliklinik/poliklinik_view.dart';
import 'package:provider/provider.dart';

import 'admin_state.dart';
import 'dashboard/dashboard_view.dart';
import 'sidebar.dart';
import 'user/user_view.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  FloatingActionButton? _fabFor(BuildContext context, AdminPage page) {
    switch (page) {
      case AdminPage.users:
        return FloatingActionButton(
          onPressed: () {
            // TODO: add user
          },
          child: const Icon(Icons.add),
        );
      case AdminPage.poliklinik:
        return FloatingActionButton(
          onPressed: () {
            // TODO: add poliklinik
          },
          child: const Icon(Icons.add),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final page = context.watch<AdminState>().page;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        automaticallyImplyLeading: !isDesktop,
        leading: isDesktop
            ? null
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
      ),
      drawer: isDesktop ? null : const SidebarDrawer(),

      floatingActionButton: _fabFor(context, page),

      body: Row(
        children: [
          if (isDesktop) const SidebarPanel(),
          Expanded(
            child: Material(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const _AdminContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminContent extends StatelessWidget {
  const _AdminContent();

  @override
  Widget build(BuildContext context) {
    final page = context.watch<AdminState>().page;

    switch (page) {
      case AdminPage.poliklinik:
        return const PoliklinikView();
      case AdminPage.dokter:
        return const PoliklinikView();
      case AdminPage.users:
        return const UsersView();
      case AdminPage.dashboard:
        return const DashboardView();
    }
  }
}
