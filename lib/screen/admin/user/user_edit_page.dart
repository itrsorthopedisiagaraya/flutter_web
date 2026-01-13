import 'package:flutter/material.dart';

import 'widget/user_form.dart';

class UserEditPage extends StatelessWidget {
  final String userId;

  const UserEditPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // TEMP: fake user data
    final user = {
      'id': userId,
      'name': 'User $userId',
      'email': 'user$userId@email.com',
      'role': 'admin',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: UserForm(
          initialData: user,
          onSubmit: (data) {
            debugPrint('UPDATE USER: $data');

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
