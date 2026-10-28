import 'package:material_ui/material_ui.dart';

/// Tokens of the Root101 brand (dark only): "Marca · Color y tipografía" of the
/// design canvas, plus the in-between shades the landing uses
class AppColors {
  static final AppColors _instance = AppColors._internal();

  AppColors._internal();

  factory AppColors() => _instance;

  final SurfaceColor surface = const SurfaceColor();
  final BrandColor brand = const BrandColor();
  final TextColor text = const TextColor();
  final NeutralColor neutral = const NeutralColor();
}

class BrandColor {
  const BrandColor();

  /// Root Indigo: actions, links, the gear: 5b5bff
  Color get indigo => const Color(0xFF5B5BFF);

  /// Señal: what is alive (a cursor, a state, the code of the mark): 5cf2c0
  Color get signal => const Color(0xFF5CF2C0);

  /// A link in [signal] on hover: a8ffe2
  Color get signalHover => const Color(0xFFA8FFE2);

  /// Navy 101, the original blue: 0b0b45
  Color get navy => const Color(0xFF0B0B45);
}

class SurfaceColor {
  const SurfaceColor();

  /// Vacío, the page: 06071a
  Color get background => const Color(0xFF06071A);

  /// Placa, cards: 0c0e2b
  Color get plate => const Color(0xFF0C0E2B);

  /// [plate] at 80 %: pills and secondary buttons over the hero
  Color get plateGlass => const Color(0xCC0C0E2B);

  /// [plate] at 40 %: idle project tabs, the open seat
  Color get plateFaint => const Color(0x660C0E2B);

  /// Icon tiles and tags: 14173d
  Color get chip => const Color(0xFF14173D);

  /// The open project tab: 0f1238
  Color get selected => const Color(0xFF0F1238);

  /// The marquee band: 0a0b24
  Color get band => const Color(0xFF0A0B24);

  /// Window frames (terminal, previews): 090a22
  Color get window => const Color(0xFF090A22);

  /// The header over the page, blurred: [background] at 72 %
  Color get glass => const Color(0xB806071A);

  /// Trazo, borders: 22264f
  Color get stroke => const Color(0xFF22264F);

  /// Window borders and the traffic lights: 2a2e66
  Color get strokeStrong => const Color(0xFF2A2E66);

  /// A tab or the dashed seat on hover: 3a3f8a
  Color get strokeHover => const Color(0xFF3A3F8A);
}

class TextColor {
  const TextColor();

  /// Tinta: eef0ff
  Color get primary => const Color(0xFFEEF0FF);

  /// Niebla, the second text: 9ba1cc
  Color get secondary => const Color(0xFF9BA1CC);

  /// A project's description and the member tags: c4c8ec
  Color get soft => const Color(0xFFC4C8EC);

  /// Over [BrandColor.indigo]
  Color get onBrand => const Color(0xFFFFFFFF);
}

class NeutralColor {
  const NeutralColor();

  Color get white => const Color(0xFFFFFFFF);

  Color get black => const Color(0xFF000000);

  Color get transparent => Colors.transparent;
}
