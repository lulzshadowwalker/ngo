import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

class ToastMessage {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  /// Show a toast message at the top of the screen
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    if (_isShowing) {
      hide();
    }

    _isShowing = true;
    _overlayEntry = _createOverlayEntry(
      context: context,
      message: message,
      title: title,
      type: type,
      duration: duration,
      onTap: onTap,
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Auto hide after duration
    Future.delayed(duration, () {
      hide();
    });
  }

  /// Hide the current toast message
  static void hide() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isShowing = false;
    }
  }

  /// Create the overlay entry for the toast
  static OverlayEntry _createOverlayEntry({
    required BuildContext context,
    required String message,
    String? title,
    required ToastType type,
    required Duration duration,
    VoidCallback? onTap,
  }) {
    return OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        title: title,
        type: type,
        onTap: onTap,
        onDismiss: hide,
      ),
    );
  }

  /// Convenience methods for different toast types
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Success',
      type: ToastType.success,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Error',
      type: ToastType.error,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Warning',
      type: ToastType.warning,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Info',
      type: ToastType.info,
      duration: duration,
    );
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final String? title;
  final ToastType type;
  final VoidCallback? onTap;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    this.title,
    required this.type,
    this.onTap,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _animationController.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: widget.onTap ?? _dismiss,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getBackgroundColor(),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Icon
                        Icon(_getIcon(), color: _getIconColor(), size: 24),
                        const SizedBox(width: 12),

                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.title != null) ...[
                                Text(
                                  widget.title!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _getTextColor(),
                                  ),
                                ),
                                const SizedBox(height: 2),
                              ],
                              Text(
                                widget.message,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _getTextColor(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Dismiss button
                        GestureDetector(
                          onTap: _dismiss,
                          child: Icon(
                            Icons.close,
                            color: _getTextColor().withOpacity(0.7),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case ToastType.success:
        return Colors.green[50]!;
      case ToastType.error:
        return Colors.red[50]!;
      case ToastType.warning:
        return Colors.orange[50]!;
      case ToastType.info:
        return Colors.blue[50]!;
    }
  }

  Color _getIconColor() {
    switch (widget.type) {
      case ToastType.success:
        return Colors.green[600]!;
      case ToastType.error:
        return Colors.red[600]!;
      case ToastType.warning:
        return Colors.orange[600]!;
      case ToastType.info:
        return Colors.blue[600]!;
    }
  }

  Color _getTextColor() {
    switch (widget.type) {
      case ToastType.success:
        return Colors.green[800]!;
      case ToastType.error:
        return Colors.red[800]!;
      case ToastType.warning:
        return Colors.orange[800]!;
      case ToastType.info:
        return Colors.blue[800]!;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }
}
