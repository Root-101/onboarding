import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Shown while the app initializes, right after the splash of `web/index.html`
/// (removed on the first frame): the same glowing mark, so there is no jump
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
          child: GlowShadow(
            color: colors.brand.indigo.withValues(alpha: 0.6),
            blur: 24,
            child: const Root101Mark(width: 150, spin: true),
          ),
        ),
      ),
    );
  }
}
