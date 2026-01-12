import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

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
      ],
      rows: users
          .map(
            (u) => DataRow(
              cells: [
                DataCell(Text(u['name']!)),
                DataCell(Text(u['email']!)),
                DataCell(Text(u['role']!)),
              ],
            ),
          )
          .toList(),
    );
  }
}
