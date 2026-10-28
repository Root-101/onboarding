import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

/// A 24x24 stroke icon from its SVG markup. Only for the project previews,
/// which draw other apps with dozens of one-off icons; the site's own icons
/// are files ([SvgAsset])
class StrokeIcon extends StatelessWidget {
  /// The SVG elements (`<path d="…"/><circle …/>`)
  final String body;
  final double size;
  final Color color;
  final double strokeWidth;

  /// Fills the shapes with [color] too (a pinned pin)
  final bool filled;

  const StrokeIcon(
    this.body, {
    required this.size,
    required this.color,
    super.key,
    this.strokeWidth = 2,
    this.filled = false,
  });

  static String _hex(Color c) =>
      '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

  @override
  Widget build(BuildContext context) {
    final hex = _hex(color);
    final opacity = color.a;
    return SvgPicture.string(
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" '
      'fill="${filled ? hex : 'none'}" stroke="$hex" stroke-opacity="$opacity" '
      'fill-opacity="$opacity" stroke-width="$strokeWidth" '
      'stroke-linecap="round" stroke-linejoin="round">$body</svg>',
      width: size,
      height: size,
    );
  }
}
