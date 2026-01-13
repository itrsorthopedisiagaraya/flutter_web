import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../helper.dart';

class PoliklinikTable extends StatelessWidget {
  final List<Map<String, String>> poliklinik;

  const PoliklinikTable({super.key, required this.poliklinik});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      minWidth: 900,
      columns: const [
        DataColumn(label: Text('Kode')),
        DataColumn(label: Text('Nama Poliklinik')),
        DataColumn(label: Text('Actions')),
      ],
      rows: poliklinik.map((u) {
        return DataRow(
          cells: [
            DataCell(Text(u['kode']!)),
            DataCell(Text(u['nama_poli']!)),
            DataCell(
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    tooltip: 'Delete',
                    onPressed: () => showConfirmDialog(
                      context,
                      title: 'Delete ${u['nama_poli']}',
                      message: 'This action cannot be undone.',
                      confirmLabel: 'Delete',
                      onConfirm: () {
                        debugPrint(u['nama_poli']);
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
