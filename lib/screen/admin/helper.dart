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

Future<void> showSearchablePicker(
  BuildContext context, {
  required String title,
  required List<String> items,
  String? selected,
  required ValueChanged<String> onSelected,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _SearchablePickerSheet(
      title: title,
      items: items,
      selected: selected,
      onSelected: onSelected,
    ),
  );
}

class _SearchablePickerSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selected;
  final ValueChanged<String> onSelected;

  const _SearchablePickerSheet({
    required this.title,
    required this.items,
    this.selected,
    required this.onSelected,
  });

  @override
  State<_SearchablePickerSheet> createState() => _SearchablePickerSheetState();
}

class _SearchablePickerSheetState extends State<_SearchablePickerSheet> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.items
        .where((i) => i.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔹 Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          // 🔹 Search
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => query = v),
            ),
          ),

          // 🔹 List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final item = filtered[i];
                final selected = item == widget.selected;

                return ListTile(
                  title: Text(item),
                  trailing: selected ? const Icon(Icons.check) : null,
                  onTap: () {
                    widget.onSelected(item);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
