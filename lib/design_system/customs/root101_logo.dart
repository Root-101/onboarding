import 'dart:math' as math;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The symbol: 1 · gear · 1 with the code inside (viewBox `8 6 106 68`).
/// [spin] turns the gear every 16 s (`.r1-gear`)
class Root101Mark extends StatelessWidget {
  static const double _viewWidth = 106;
  static const double _viewHeight = 68;

  final double width;
  final bool spin;

  const Root101Mark({required this.width, super.key, this.spin = false});

  @override
  Widget build(BuildContext context) {
    final scale = width / _viewWidth;
    final brand = app.assets.brand;
    final gearSize = 55 * scale;
    final gear = brand.markGear.build(size: gearSize);
    return SizedBox(
      width: width,
      height: _viewHeight * scale,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // mark_gear.svg is the square (35.5, 12.5) 55x55 of the mark
          Positioned(
            left: (35.5 - 8) * scale,
            top: (12.5 - 6) * scale,
            width: gearSize,
            height: gearSize,
            child: spin
                ? LoopAnimation(
                    duration: const Duration(seconds: 16),
                    child: gear,
                    builder: (context, value, child) => Transform.rotate(
                      angle: value * 2 * math.pi,
                      child: child,
                    ),
                  )
                : gear,
          ),
          Positioned.fill(child: brand.markBody.build(fit: BoxFit.contain)),
        ],
      ),
    );
  }
}

/// `root101`, the `101` in signal (viewBox `0 -720 3328 740`)
class Root101Wordmark extends StatelessWidget {
  final double width;

  const Root101Wordmark({required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'root101',
      child: app.assets.brand.wordmark.sized(
        width: width,
        height: width * 740 / 3328,
      ),
    );
  }
}

/// The mark and the wordmark side by side (header, footer)
class Root101Lockup extends StatelessWidget {
  final double markWidth;
  final double wordWidth;
  final double gap;

  const Root101Lockup({
    required this.markWidth,
    required this.wordWidth,
    required this.gap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: gap,
      children: [
        Root101Mark(width: markWidth),
        Root101Wordmark(width: wordWidth),
      ],
    );
  }
}
