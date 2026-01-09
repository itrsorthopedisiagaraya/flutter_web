import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

void showTopToast(
  BuildContext context, {
  required String message,
  SnackBarType type = SnackBarType.info,
}) {
  final overlay = Overlay.of(context);

  final media = MediaQuery.of(context);
  final screenWidth = media.size.width;

  // Responsive width
  double toastWidth;
  if (screenWidth < 600) {
    toastWidth = screenWidth - 32; // mobile
  } else if (screenWidth < 1024) {
    toastWidth = 480; // tablet
  } else {
    toastWidth = 420; // desktop/web
  }

  Color bgColor;
  IconData icon;

  switch (type) {
    case SnackBarType.success:
      bgColor = Colors.teal;
      icon = Icons.check_circle_outline;
      break;
    case SnackBarType.error:
      bgColor = Colors.red;
      icon = Icons.error_outline;
      break;
    case SnackBarType.warning:
      bgColor = Colors.orange;
      icon = Icons.warning_amber_outlined;
      break;
    case SnackBarType.info:
      bgColor = Theme.of(context).colorScheme.primary;
      icon = Icons.info_outline;
  }

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Positioned(
      top: media.padding.top + 16,
      left: (screenWidth - toastWidth) / 2,
      width: toastWidth,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);

  Future.delayed(const Duration(seconds: 2), () {
    entry.remove();
  });
}
