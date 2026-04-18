import 'package:flutter/material.dart';

class AppTokens {
  static const Color brand900 = Color(0xFF0E355B);
  static const Color brand700 = Color(0xFF16548A);
  static const Color brand500 = Color(0xFF1C6BB0);
  static const Color accent = Color(0xFF0EA5A5);

  static const Color bg = Color(0xFFF2F6FB);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFD3DFEE);
  static const Color textPrimary = Color(0xFF13283A);
  static const Color textMuted = Color(0xFF5A6D80);

  static const double radiusLg = 18;
  static const double radiusXl = 24;
  static const Duration motionFast = Duration(milliseconds: 220);
  static const Duration motionBase = Duration(milliseconds: 320);
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppTokens.brand700,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppTokens.bg,
    appBarTheme: base.appBarTheme.copyWith(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppTokens.textPrimary,
    ),
    textTheme: base.textTheme.copyWith(
      titleLarge: const TextStyle(
        fontWeight: FontWeight.w800,
        color: AppTokens.textPrimary,
      ),
      bodyMedium: const TextStyle(
        color: AppTokens.textPrimary,
      ),
      bodySmall: const TextStyle(
        color: AppTokens.textMuted,
      ),
    ),
    cardTheme: base.cardTheme.copyWith(
      color: AppTokens.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusLg),
        side: const BorderSide(color: AppTokens.border),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppTokens.brand700.withValues(alpha: 0.14),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          color: selected ? AppTokens.brand900 : AppTokens.textMuted,
        );
      }),
    ),
  );
}
