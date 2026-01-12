import 'package:flutter/material.dart';
import '../../helper.dart';

class UsersList extends StatelessWidget {
  final List<Map<String, String>> users;

  const UsersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (_, i) {
        final u = users[i];

        return ListTile(
          title: Text(u['name']!),
          subtitle: Text(u['email']!),
          onTap: () {
            showActionSheet(
              context,
              actions: [
                ActionSheetItem(
                  label: 'Edit',
                  icon: Icons.edit,
                  onTap: () {
                    // navigate to edit user
                  },
                ),
                ActionSheetItem(
                  label: 'Delete',
                  icon: Icons.delete,
                  destructive: true,
                  onTap: () {
                    showConfirmDialog(
                      context,
                      title: 'Delete ${u['name']}',
                      message: 'This action cannot be undone.',
                      confirmLabel: 'Delete',
                      onConfirm: () {
                        debugPrint(u['name']);
                      },
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
