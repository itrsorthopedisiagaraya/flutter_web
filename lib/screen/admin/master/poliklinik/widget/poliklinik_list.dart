import 'package:flutter/material.dart';

import '../../../helper.dart';

class PoliklinikList extends StatelessWidget {
  final List<Map<String, String>> poliklinik;

  const PoliklinikList({super.key, required this.poliklinik});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: poliklinik.length,
      itemBuilder: (_, i) {
        final u = poliklinik[i];

        return ListTile(
          title: Text(u['kode']!),
          subtitle: Text(u['nama_poli']!),
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
                      title: 'Delete ${u['nama_poli']}',
                      message: 'This action cannot be undone.',
                      confirmLabel: 'Delete',
                      onConfirm: () {
                        debugPrint(u['nama_poli']);
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
