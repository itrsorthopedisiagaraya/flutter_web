import 'package:flutter/material.dart';
import 'widget/user_form.dart';

class UserCreatePage extends StatelessWidget {
  const UserCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: UserForm(
          onSubmit: (data) {
            debugPrint('CREATE USER: $data');

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
