import 'dart:ui' show ImageFilter;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The bar pinned on top, the page blurred under it: the logo, the sections,
/// the language and GitHub
class HomeHeader extends StatelessWidget {
  /// 14 + 44 + 14 and its bottom border
  static const double height = 73;

  final void Function(HomeSection section) onNavigate;

  const HomeHeader({required this.onNavigate, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final intl = context.intl.nav;
    Widget section(String label, HomeSection target) => AppLink(
      onPressed: () => onNavigate(target),
      builder: (context, hovered) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          label,
          style: TextStyle(fontSize: 15, color: colors.text.secondary),
        ),
      ),
    );

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: colors.surface.glass,
            border: Border(
              bottom: BorderSide(
                color: colors.surface.stroke.withValues(alpha: 0.8),
              ),
            ),
          ),
          child: PageColumn(
            child: Row(
              children: [
                AppLink(
                  onPressed: () => onNavigate(HomeSection.top),
                  builder: (context, _) => const Root101Lockup(
                    markWidth: 46,
                    wordWidth: 77,
                    gap: 12,
                  ),
                ),
                const Spacer(),
                Row(
                  spacing: 24,
                  children: [
                    section(intl.about, HomeSection.about),
                    section(intl.projects, HomeSection.projects),
                    section(intl.team, HomeSection.team),
                    Row(
                      spacing: 12,
                      children: [
                        const LanguageWidget(),
                        AppButton.secondary(
                          label: intl.github,
                          url: Site.github,
                          icon: app.assets.icons.actions.github,
                          height: 44,
                          fontSize: 15,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          borderRadius: app.dimensions.radius.s,
                          background: colors.surface.plate,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
