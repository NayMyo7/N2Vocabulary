import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';
import 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = ThemeData.light().textTheme;

    return MaterialApp.router(
      title: 'N2 Vocabulary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          onPrimary: AppColors.textOnPrimary,
          onSecondary: AppColors.textOnPrimary,
          onSurface: AppColors.textPrimary,
          error: AppColors.error,
          onError: AppColors.textOnPrimary,
        ),
        dividerColor: AppColors.divider,
        hintColor: AppColors.textSecondary,
        fontFamily: 'Roboto',
        // Fix AppBar background color
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          surfaceTintColor: AppColors.primary,
        ),
        // Simplified text theme to improve startup performance
        textTheme: baseTextTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
          fontFamily: 'Roboto',
        ),
      ),
      routerConfig: createRouter(),
    );
  }
}
