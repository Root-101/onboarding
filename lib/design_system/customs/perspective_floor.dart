import 'dart:math' as math;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// `.r1-floor`: a grid of 64 px lying down in perspective (520 px, tilted
/// 64°), running towards the viewer every 2.4 s and fading out to the top.
/// It fills its parent: place it like the design (200 % wide, 68 % tall,
/// 8 % below the bottom)
class PerspectiveFloor extends StatelessWidget {
  static const double cell = 64;

  const PerspectiveFloor({super.key});

  @override
  Widget build(BuildContext context) {
    final transform = Matrix4.identity()
      ..setEntry(3, 2, -1 / 520)
      ..rotateX(64 * math.pi / 180);
    return IgnorePointer(
      child: Transform(
        alignment: Alignment.bottomCenter,
        transform: transform,
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (rect) => const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFF000000), Color(0xFF000000), Color(0x00000000)],
            stops: [0, 0.05, 0.8],
          ).createShader(rect),
          child: LoopAnimation(
            duration: const Duration(milliseconds: 2400),
            builder: (context, value, _) => CustomPaint(
              size: Size.infinite,
              painter: _GridPainter(
                shift: value * cell,
                color: app.colors.brand.indigo.withValues(alpha: 0.38),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final double shift;
  final Color color;

  _GridPainter({required this.shift, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const cell = PerspectiveFloor.cell;
    for (double x = 0; x < size.width; x += cell) {
      canvas.drawRect(Rect.fromLTWH(x, 0, 1, size.height), paint);
    }
    for (double y = shift - cell; y < size.height; y += cell) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) =>
      old.shift != shift || old.color != color;
}
