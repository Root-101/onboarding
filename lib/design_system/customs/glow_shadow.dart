import 'dart:ui' show ImageFilter;

import 'package:material_ui/material_ui.dart';

/// CSS `filter: drop-shadow(0 0 [blur]px [color])`: a blurred copy of the
/// child's shape in [color], behind it
class GlowShadow extends StatelessWidget {
  final Color color;
  final double blur;
  final Widget child;

  const GlowShadow({
    required this.color,
    required this.blur,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blur / 2, sigmaY: blur / 2),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              child: child,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
