import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// A desktop window: a bar with three dots and a [title], and its [child]
/// below. The hero's terminal and the project preview
class WindowFrame extends StatelessWidget {
  final Widget title;

  /// The title in the middle of the bar instead of after the dots
  final bool centerTitle;
  final double dotSize;
  final EdgeInsets barPadding;
  final BorderRadius borderRadius;
  final Color background;
  final List<BoxShadow> shadows;
  final Widget child;

  const WindowFrame({
    required this.title,
    required this.borderRadius,
    required this.background,
    required this.shadows,
    required this.child,
    super.key,
    this.centerTitle = false,
    this.dotSize = 12,
    this.barPadding = const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    final colors = app.colors.surface;
    final dot = Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: colors.strokeStrong,
        shape: BoxShape.circle,
      ),
    );
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background,
        borderRadius: borderRadius,
        border: Border.all(color: colors.strokeStrong),
        boxShadow: shadows,
      ),
      // as tall as the bar and the child: the child gives its own height
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: barPadding,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colors.stroke)),
            ),
            child: Row(
              spacing: 8,
              children: [
                dot,
                dot,
                dot,
                if (centerTitle)
                  Expanded(child: Center(child: title))
                else
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: title,
                  ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// CSS `radial-gradient(color r, transparent …)` tiled every [spacing]: the
/// dotted backgrounds of the previews
class DotGridPainter extends CustomPainter {
  final Color color;
  final double spacing;
  final double radius;

  const DotGridPainter({
    required this.color,
    required this.spacing,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (double y = spacing / 2; y < size.height; y += spacing) {
      for (double x = spacing / 2; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DotGridPainter old) =>
      old.color != color || old.spacing != spacing || old.radius != radius;
}
