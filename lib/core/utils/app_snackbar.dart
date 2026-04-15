import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void success(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      title,
      message,
      backgroundColor: const Color(0xFFD1FAE5), // light green
      foregroundColor: const Color(0xFF065F46), // dark green
      icon: const Icon(Icons.check_circle_rounded, color: Color(0xFF065F46)),
      duration: duration,
    );
  }

  static void error(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      title,
      message,
      backgroundColor: const Color(0xFFFEE2E2), // light red
      foregroundColor: const Color(0xFF991B1B), // dark red
      icon: const Icon(Icons.error_rounded, color: Color(0xFF991B1B)),
      duration: duration,
    );
  }

  static void _show(
    String title,
    String message, {
    required Color backgroundColor,
    required Color foregroundColor,
    required Widget icon,
    required Duration duration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      backgroundColor: backgroundColor,
      colorText: foregroundColor,
      icon: icon,
      duration: duration,
      borderRadius: 14,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}

