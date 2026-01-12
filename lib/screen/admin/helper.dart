import 'package:flutter/material.dart';

import '../../helper.dart';

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

void confirmLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      icon: const Icon(Icons.logout),
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            _logout(context);
          },
          child: const Text('Logout'),
        ),
      ],
    ),
  );
}

void _logout(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

  showTopToast(
    context,
    message: 'Logged out successfully',
    type: SnackBarType.success,
  );
}
