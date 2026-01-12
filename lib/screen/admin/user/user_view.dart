import 'package:flutter/material.dart';

import 'widget/user_list.dart';
import 'widget/user_search.dart';
import 'widget/user_table.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  final List<Map<String, String>> _users = List.generate(
    20,
    (i) => {'name': 'User $i', 'email': 'user$i@email.com', 'role': 'Admin'},
  );

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    final filteredUsers = _users.where((u) {
      final q = _query.toLowerCase();
      return u['name']!.toLowerCase().contains(q) ||
          u['email']!.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        UsersSearch(
          controller: _searchCtrl,
          onChanged: (v) => setState(() => _query = v),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: isDesktop
              ? UsersTable(users: filteredUsers)
              : UsersList(users: filteredUsers),
        ),
      ],
    );
  }
}
