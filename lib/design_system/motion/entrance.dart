import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// `.r1-shot`: fades in from 16 px below at 98.5 % when it is built. Give it a
/// new key to play it again
class Entrance extends StatefulWidget {
  final Widget child;

  const Entrance({required this.child, super.key});

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance>
    with SingleTickerProviderStateMixin {
  static const Curve _curve = Cubic(0.2, 0.7, 0.2, 1);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return widget.child;
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final t = _curve.transform(_controller.value);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - t)),
            child: Transform.scale(scale: 0.985 + 0.015 * t, child: child),
          ),
        );
      },
    );
  }
}
