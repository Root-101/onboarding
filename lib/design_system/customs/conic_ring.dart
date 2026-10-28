import 'dart:math' as math;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// `.r1-ring`: a light running around the border every 5 s (a conic gradient
/// turning behind the card, [width] of it showing as the border)
class ConicRing extends StatelessWidget {
  final BorderRadius borderRadius;
  final double width;
  final Widget child;

  const ConicRing({
    required this.borderRadius,
    required this.child,
    super.key,
    this.width = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, box) {
                // `inset: -60%`, square so the corners never show while it turns
                final side = math.max(box.maxWidth, box.maxHeight) * 2.2;
                return OverflowBox(
                  maxWidth: side,
                  maxHeight: side,
                  child: LoopAnimation(
                    duration: const Duration(seconds: 5),
                    builder: (context, t, _) => Transform.rotate(
                      angle: t * 2 * math.pi,
                      child: SizedBox.square(
                        dimension: side,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: SweepGradient(
                              // `from 0deg` starts at the top, not at 3 o'clock
                              transform: const GradientRotation(-math.pi / 2),
                              colors: [
                                colors.neutral.transparent,
                                colors.neutral.transparent,
                                colors.brand.signal,
                                colors.brand.indigo,
                                colors.neutral.transparent,
                              ],
                              stops: const [0, 0.68, 0.8, 0.9, 1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(width), child: child),
        ],
      ),
    );
  }
}

/// `.r1-scan`: a faint 80 px band of signal across its parent, still, [top]
/// from the top (behind the name of a member card). Put it in a [Stack]
class ScanLine extends StatelessWidget {
  final double top;

  const ScanLine({required this.top, super.key});

  @override
  Widget build(BuildContext context) {
    final signal = app.colors.brand.signal;
    return Positioned(
      left: 0,
      right: 0,
      top: top,
      height: 80,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                signal.withValues(alpha: 0),
                signal.withValues(alpha: 0.03),
                signal.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
