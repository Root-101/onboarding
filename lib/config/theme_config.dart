import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

class ThemeConfig {
  ThemeConfig._();

  /// Material widgets without their own style take the palette, not the
  /// Material 3 default colors
  static ThemeData get theme {
    final colors = app.colors;
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppText.sans,
      scaffoldBackgroundColor: colors.surface.background,
      colorScheme: ColorScheme.dark(
        primary: colors.brand.indigo,
        onPrimary: colors.text.onBrand,
        secondary: colors.brand.signal,
        onSecondary: colors.surface.background,
        surface: colors.surface.plate,
        onSurface: colors.text.primary,
        onSurfaceVariant: colors.text.secondary,
        outline: colors.surface.stroke,
        outlineVariant: colors.surface.stroke,
      ),
      focusColor: colors.brand.indigo.withValues(alpha: 0.24),
      hoverColor: colors.neutral.transparent,
      splashFactory: NoSplash.splashFactory,
      textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: AppText.sans,
        bodyColor: colors.text.primary,
        displayColor: colors.text.primary,
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: colors.surface.chip,
          borderRadius: app.dimensions.radius.xs,
        ),
        textStyle: TextStyle(
          fontFamily: AppText.sans,
          fontSize: 12,
          color: colors.text.primary,
        ),
      ),
    );
  }
}
