import 'package:flutter/material.dart';

enum SnackBarThemedType {
  error,
  info,
  success,
  warning,
}

class SnackBarThemed {
  const SnackBarThemed({
    required this.type,
    required this.message,
    required this.context,
  });

  final SnackBarThemedType type;
  final String message;
  final BuildContext context;
  

  Color textColor() {
    switch (type) {
      case SnackBarThemedType.error:
        return Colors.red.shade900;
      case SnackBarThemedType.info:
        return Colors.blue.shade900;
      case SnackBarThemedType.success:
        return Colors.green.shade900;
      case SnackBarThemedType.warning:
        return Colors.lime.shade900;
      default:
        return Colors.blue.shade900;
    }
  }

  Color backgroundColor() {
    switch (type) {
      case SnackBarThemedType.error:
        return Colors.red.shade100;
      case SnackBarThemedType.info:
        return Colors.blue.shade100;
      case SnackBarThemedType.success:
        return Colors.green.shade100;
      case SnackBarThemedType.warning:
        return Colors.lime.shade100;
      default:
        return Colors.blue.shade100;
    }
  }

  void show() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor(),
        content: Text(
          message,
          style: TextStyle(
            color: textColor(),
          ),
        ),
      ),
    );
  }
}
