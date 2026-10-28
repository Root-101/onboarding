import 'dart:math' as math;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Strokes [path] in dashes. [phase] moves the pattern forward along the path
/// (to animate it, like `stroke-dashoffset`)
void drawDashedPath(
  Canvas canvas,
  Path path,
  Paint paint, {
  required double dash,
  required double gap,
  double phase = 0,
}) {
  final period = dash + gap;
  for (final metric in path.computeMetrics()) {
    for (double d = phase % period - period; d < metric.length; d += period) {
      final start = math.max(0.0, d);
      final end = math.min(metric.length, d + dash);
      if (end > start) canvas.drawPath(metric.extractPath(start, end), paint);
    }
  }
}

/// A dashed rounded border around [child] (CSS `border: dashed`)
class DashedBorder extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dash;
  final double gap;
  final Widget? child;

  const DashedBorder({
    required this.color,
    super.key,
    this.strokeWidth = 1.5,
    this.radius = 10,
    this.dash = 6,
    this.gap = 4,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _DashedRRectPainter(this),
      child: child,
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  final DashedBorder b;

  _DashedRRectPainter(this.b);

  @override
  void paint(Canvas canvas, Size size) {
    final inset = b.strokeWidth / 2;
    final rect = (Offset.zero & size).deflate(inset);
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(b.radius)));
    final paint = Paint()
      ..color = b.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = b.strokeWidth;
    drawDashedPath(canvas, path, paint, dash: b.dash, gap: b.gap);
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) =>
      old.b.color != b.color || old.b.strokeWidth != b.strokeWidth;
}

/// `.r1-flow`: a dashed line whose dashes run forward (6/6, a lap per second)
class FlowLine extends StatelessWidget {
  final double width;
  final Color color;

  const FlowLine({required this.width, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return LoopAnimation(
      duration: const Duration(milliseconds: 500),
      builder: (context, t, _) => CustomPaint(
        size: Size(width, 12),
        painter: _FlowPainter(color: color, phase: t * 12),
      ),
    );
  }
}

class _FlowPainter extends CustomPainter {
  final Color color;
  final double phase;

  _FlowPainter({required this.color, required this.phase});

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    final path = Path()
      ..moveTo(2, y)
      ..lineTo(size.width - 2, y);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    drawDashedPath(canvas, path, paint, dash: 6, gap: 6, phase: phase);
  }

  @override
  bool shouldRepaint(covariant _FlowPainter old) =>
      old.phase != phase || old.color != color;
}
