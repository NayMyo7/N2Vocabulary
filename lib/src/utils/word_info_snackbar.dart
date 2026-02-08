import 'package:flutter/material.dart';

import '../domain/models/vocabulary.dart';

/// Utility class for displaying vocabulary information in a SnackBar.
class WordInfoSnackBar {
  WordInfoSnackBar._();

  /// Shows a SnackBar with vocabulary's week, day, and ID information.
  static void show(BuildContext context, Vocabulary vocabulary) {
    final week = vocabulary.week;
    final dayOfWeek = vocabulary.day;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Week $week / Day $dayOfWeek / No. ${vocabulary.id}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        width: 200,
      ),
    );
  }
}
