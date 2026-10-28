import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// `.r1-pulse`: a signal dot sending a ring out every 1.6 s
class PulseDot extends StatelessWidget {
  final double size;

  const PulseDot({super.key, this.size = 8});

  @override
  Widget build(BuildContext context) {
    final color = app.colors.brand.signal;
    return LoopAnimation(
      duration: const Duration(milliseconds: 1600),
      curve: Curves.easeOut,
      builder: (context, t, _) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.6 * (1 - t)),
              spreadRadius: 10 * t,
            ),
          ],
        ),
      ),
    );
  }
}

/// `.r1-caret`: a block cursor on for half a second, off for the other half
class BlinkingCaret extends StatelessWidget {
  final TextStyle style;

  const BlinkingCaret({required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return LoopAnimation(
      duration: const Duration(seconds: 1),
      builder: (context, t, _) => Opacity(
        opacity: t < 0.5 ? 1 : 0,
        child: Text('▍', style: style.copyWith(color: app.colors.brand.signal)),
      ),
    );
  }
}

/// `.r1-float`: bobs 12 px up and down every 7 s
class Floating extends StatelessWidget {
  final Widget child;

  const Floating({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return LoopAnimation(
      duration: const Duration(milliseconds: 3500),
      reverse: true,
      curve: Curves.easeInOut,
      child: child,
      builder: (context, t, child) =>
          Transform.translate(offset: Offset(0, -12 * t), child: child),
    );
  }
}

/// `.r1-marq`: [children] scrolling left forever, [gap] apart, one lap every
/// [duration]
class Marquee extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final Duration duration;

  const Marquee({
    required this.children,
    required this.gap,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // two laps, each item followed by its gap: -50 % is exactly one lap
    final lap = [
      for (final child in children) ...[child, SizedBox(width: gap)],
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: LoopAnimation(
        duration: duration,
        child: Row(mainAxisSize: MainAxisSize.min, children: [...lap, ...lap]),
        builder: (context, t, child) =>
            FractionalTranslation(translation: Offset(-t / 2, 0), child: child),
      ),
    );
  }
}
