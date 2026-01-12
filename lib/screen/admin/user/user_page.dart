import 'package:flutter/material.dart';

import 'user_view.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: const Padding(padding: EdgeInsets.all(16), child: UsersView()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
