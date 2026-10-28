import 'dart:math' as math;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Space Grotesk for titles (700) and text (400/500), JetBrains Mono for
/// labels, code and data. Letter spacing in `em` like the design: `em(-0.05,
/// 92)`
class AppText {
  AppText._();

  static const String sans = 'SpaceGrotesk';

  static const String monoFamily = 'JetBrainsMono';

  static double em(double value, double fontSize) => value * fontSize;

  /// CSS `clamp(min, vw%, max)` of the design's big titles
  static double clampVw(
    BuildContext context, {
    required double min,
    required double vw,
    required double max,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    return math.min(max, math.max(min, width * vw / 100));
  }

  static const TextStyle mono = TextStyle(fontFamily: monoFamily);

  /// `01 · QUÉ HACEMOS`: the label over a section title
  static TextStyle get overline => TextStyle(
    fontFamily: monoFamily,
    fontSize: 13,
    letterSpacing: em(0.1, 13),
    color: app.colors.brand.signal,
  );

  /// A section title: `clamp(34px, 4.6vw, 56px)`
  static TextStyle sectionTitle(BuildContext context) {
    final size = clampVw(context, min: 34, vw: 4.6, max: 56);
    return TextStyle(
      fontSize: size,
      height: 1.04,
      fontWeight: FontWeight.w700,
      letterSpacing: em(-0.04, size),
      color: app.colors.text.primary,
    );
  }

  /// Text beside a title
  static TextStyle get lead =>
      TextStyle(fontSize: 17, height: 1.55, color: app.colors.text.secondary);

  /// Text of a card
  static TextStyle get body =>
      TextStyle(fontSize: 15, height: 1.55, color: app.colors.text.secondary);

  /// Title of a card
  static TextStyle get cardTitle => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: em(-0.02, 22),
    color: app.colors.text.primary,
  );

  /// Mono meta: counters, kinds, stat labels
  static TextStyle get meta => TextStyle(
    fontFamily: monoFamily,
    fontSize: 12,
    color: app.colors.text.secondary,
  );
}
