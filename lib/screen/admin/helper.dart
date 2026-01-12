import 'package:flutter/material.dart';

Future<void> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  VoidCallback? onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
}

class ActionSheetItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool destructive;

  const ActionSheetItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.destructive = false,
  });
}

void showActionSheet(
  BuildContext context, {
  required List<ActionSheetItem> actions,
}) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: actions.map((a) {
            final color = a.destructive ? Colors.redAccent : null;

            return ListTile(
              leading: Icon(a.icon, color: color),
              title: Text(a.label, style: TextStyle(color: color)),
              onTap: () {
                Navigator.pop(context);
                a.onTap();
              },
            );
          }).toList(),
        ),
      );
    },
  );
}
