import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../helper.dart';
import '../user_edit_page.dart';

class UsersTable extends StatelessWidget {
  final List<Map<String, String>> users;

  const UsersTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      minWidth: 900,
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Role')),
        DataColumn(label: Text('Actions')),
      ],
      rows: users.map((u) {
        return DataRow(
          cells: [
            DataCell(Text(u['name']!)),
            DataCell(Text(u['email']!)),
            DataCell(Text(u['role']!)),
            DataCell(
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.error_outline_outlined,
                      color: Colors.blueAccent,
                    ),
                    tooltip: 'Detail',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserEditPage(userId: u['id']!),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    tooltip: 'Delete',
                    onPressed: () => showConfirmDialog(
                      context,
                      title: 'Delete ${u['name']}',
                      message: 'This action cannot be undone.',
                      confirmLabel: 'Delete',
                      onConfirm: () {
                        debugPrint(u['name']);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
