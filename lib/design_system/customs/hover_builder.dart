import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Rebuilds with whether the mouse is over it: the `:hover` rules of the design
class HoverBuilder extends StatefulWidget {
  final MouseCursor cursor;
  final Widget Function(BuildContext context, bool hovered) builder;

  const HoverBuilder({
    required this.builder,
    super.key,
    this.cursor = MouseCursor.defer,
  });

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: widget.builder(context, _hovered),
    );
  }
}

/// `.r1-card`: lifts 6 px and lights its border in indigo on hover (.25 s)
class HoverCard extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color background;
  final Color borderColor;
  final EdgeInsets padding;
  final Widget child;

  /// Draws its own border (the dashed seat): it gets the current color
  final Widget Function(Color borderColor, Widget child)? borderBuilder;

  const HoverCard({
    required this.borderRadius,
    required this.background,
    required this.borderColor,
    required this.padding,
    required this.child,
    super.key,
    this.borderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 250);
    final content = Padding(padding: padding, child: child);
    return HoverBuilder(
      builder: (context, hovered) => TweenAnimationBuilder<double>(
        duration: duration,
        curve: Curves.ease,
        tween: Tween(end: hovered ? 1 : 0),
        builder: (context, t, _) {
          final color = Color.lerp(borderColor, app.colors.brand.indigo, t)!;
          final builder = borderBuilder;
          return Transform.translate(
            offset: Offset(0, -6 * t),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: background,
                borderRadius: borderRadius,
                border: builder == null ? Border.all(color: color) : null,
              ),
              child: builder == null ? content : builder(color, content),
            ),
          );
        },
      ),
    );
  }
}
