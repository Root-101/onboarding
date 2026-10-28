import 'package:root101/design_system/motion/loop_animation.dart';
import 'package:material_ui/material_ui.dart';

/// A soft light: CSS `radial-gradient(circle, color, transparent [fade])` on a
/// circle of [size]. With [drift] it wanders 48 px right and 36 px up and back
/// (`.r1-orb`), [reverse] starting from the other end (`.r1-orb2`)
class GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  /// Where the color is gone, as in the CSS stop (`65%`)
  final double fade;
  final Duration? drift;
  final bool reverse;

  const GlowOrb({
    required this.size,
    required this.color,
    super.key,
    this.fade = 0.65,
    this.drift,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final orb = IgnorePointer(
      child: SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              // `circle` without a size reaches the farthest corner: 0.707
              // of the side, not half of it
              radius: 0.7071,
              colors: [color, color.withValues(alpha: 0)],
              stops: [0, fade],
            ),
          ),
        ),
      ),
    );
    final period = drift;
    if (period == null) return orb;
    return LoopAnimation(
      duration: period ~/ 2,
      reverse: true,
      curve: Curves.easeInOut,
      still: reverse ? 1 : 0,
      child: orb,
      builder: (context, value, child) {
        final t = reverse ? 1 - value : value;
        return Transform.translate(
          offset: Offset(48 * t, -36 * t),
          child: child,
        );
      },
    );
  }
}

/// The light that follows the mouse over the hero: `radial-gradient(560px
/// circle at x y, color, transparent 60%)`
class SpotlightPainter extends CustomPainter {
  final Alignment at;
  final Color color;

  SpotlightPainter({required this.at, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = at.alongSize(size);
    const radius = 560.0;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0)],
        stops: const [0, 0.6],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant SpotlightPainter old) =>
      old.at != at || old.color != color;
}
