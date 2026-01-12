import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  final List<Map<String, String>> users;

  const UsersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (_, i) {
        final u = users[i];
        return ListTile(title: Text(u['name']!), subtitle: Text(u['email']!));
      },
    );
  }
}
