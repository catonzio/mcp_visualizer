import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _monoFontFamily = 'monospace';

  // Seed colour — a calm blue-grey that suits developer tooling
  static const _seed = Color(0xFF4A90D9);

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.light,
    );
    return _base(colorScheme);
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    );
    return _base(colorScheme);
  }

  static ThemeData _base(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: null, // keep system default for UI text
      textTheme: _buildTextTheme(colorScheme),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withAlpha(80),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    // mono style used for code / JSON / log output
    const monoStyle = TextStyle(fontFamily: _monoFontFamily, fontSize: 13);
    return TextTheme(
      bodySmall: monoStyle,
      labelSmall: monoStyle.copyWith(fontSize: 11),
    );
  }

  /// Returns a [TextStyle] suitable for displaying code or JSON.
  static TextStyle monoStyle({double fontSize = 13, Color? color}) {
    return TextStyle(
      fontFamily: _monoFontFamily,
      fontSize: fontSize,
      color: color,
    );
  }
}
