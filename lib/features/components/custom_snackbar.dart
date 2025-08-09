import 'package:flutter/material.dart';
import 'package:ngo/core/theme/my_colors.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
    bool showCloseButton = true,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            _getIcon(type),
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: _getBackgroundColor(type),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      duration: duration,
      action: showCloseButton
          ? SnackBarAction(
              label: actionLabel ?? 'Close',
              textColor: Colors.white,
              onPressed: onActionPressed ??
                  () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    bool showCloseButton = true,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      showCloseButton: showCloseButton,
      onActionPressed: onActionPressed,
      actionLabel: actionLabel,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    bool showCloseButton = true,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      showCloseButton: showCloseButton,
      onActionPressed: onActionPressed,
      actionLabel: actionLabel,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    bool showCloseButton = true,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      showCloseButton: showCloseButton,
      onActionPressed: onActionPressed,
      actionLabel: actionLabel,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    bool showCloseButton = true,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.info,
      duration: duration,
      showCloseButton: showCloseButton,
      onActionPressed: onActionPressed,
      actionLabel: actionLabel,
    );
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber;
      case SnackBarType.info:
        return Icons.info_outline;
    }
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return MyColors.primaryColor;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
    }
  }
}
