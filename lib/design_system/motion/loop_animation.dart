import 'package:material_ui/material_ui.dart';

extension ReduceMotionX on BuildContext {
  /// The OS asks for less motion: the design's `prefers-reduced-motion` rule
  /// stops every animation
  bool get reduceMotion => MediaQuery.of(this).disableAnimations;
}

/// A value from 0 to 1 that loops forever: an `animation: … infinite` of the
/// design. [reverse] goes back and forth (`0%,100%{a} 50%{b}` with half the
/// duration). With reduced motion it stays at [still]
class LoopAnimation extends StatefulWidget {
  final Duration duration;
  final bool reverse;
  final Curve curve;
  final double still;
  final Widget? child;
  final Widget Function(BuildContext context, double value, Widget? child)
  builder;

  const LoopAnimation({
    required this.duration,
    required this.builder,
    super.key,
    this.reverse = false,
    this.curve = Curves.linear,
    this.still = 0,
    this.child,
  });

  @override
  State<LoopAnimation> createState() => _LoopAnimationState();
}

class _LoopAnimationState extends State<LoopAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: widget.reverse);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) {
      return widget.builder(context, widget.still, widget.child);
    }
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) => widget.builder(
        context,
        widget.curve.transform(_controller.value),
        child,
      ),
    );
  }
}
