import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Shown while the app initializes, right after the splash of `web/index.html`
/// (removed on the first frame): the same glowing mark, wordmark and bar, so
/// there is no jump
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: appSupportedLocales,
      builder: (context, child) => ColoredBox(
        color: colors.surface.background,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlowShadow(
                color: colors.brand.indigo.withValues(alpha: 0.6),
                blur: 24,
                child: const Root101Mark(width: 150, spin: true),
              ),
              24.gap(),
              const Root101Wordmark(width: 220),
              28.gap(),
              const _LoadingBar(),
            ],
          ),
        ),
      ),
    );
  }
}

/// The bar of `.loader` in `web/index.html`: a segment of 40 % that crosses
/// the track every 1.2 s, or the whole track at half opacity with reduced
/// motion
class _LoadingBar extends StatelessWidget {
  static const double _width = 220;

  const _LoadingBar();

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final bar = colors.brand.signal;
    return ClipRRect(
      borderRadius: app.dimensions.radius.pill,
      child: Container(
        width: _width,
        height: 4,
        color: colors.surface.stroke,
        child: context.reduceMotion
            ? ColoredBox(color: bar.withValues(alpha: 0.5))
            : LoopAnimation(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.ease,
                builder: (context, t, _) => Stack(
                  children: [
                    Positioned(
                      left: _width * (-0.4 + 1.4 * t),
                      width: _width * 0.4,
                      top: 0,
                      bottom: 0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: bar,
                          borderRadius: app.dimensions.radius.pill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
