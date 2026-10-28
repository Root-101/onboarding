import 'dart:ui' show ImageFilter;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The bar pinned on top, the page blurred under it: the logo, the sections,
/// the language and GitHub. On a phone the sections, the language and GitHub
/// fold into a menu that opens under the bar
class HomeHeader extends StatefulWidget {
  /// 14 + 44 + 14 and its bottom border
  static const double height = 73;

  /// 10 + 44 + 10 and its bottom border
  static const double compactHeight = 65;

  static double heightOf(BuildContext context) =>
      context.isCompact ? compactHeight : height;

  final void Function(HomeSection section) onNavigate;

  const HomeHeader({required this.onNavigate, super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool _menuOpen = false;

  void _navigate(HomeSection section) {
    setState(() => _menuOpen = false);
    widget.onNavigate(section);
  }

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final intl = context.intl.nav;
    Widget section(String label, HomeSection target) => AppLink(
      onPressed: () => _navigate(target),
      builder: (context, hovered) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          label,
          style: TextStyle(fontSize: 15, color: colors.text.secondary),
        ),
      ),
    );

    final compact = context.isCompact;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: compact ? null : HomeHeader.height,
          decoration: BoxDecoration(
            color: colors.surface.glass,
            border: Border(
              bottom: BorderSide(
                color: colors.surface.stroke.withValues(alpha: 0.8),
              ),
            ),
          ),
          child: compact
              ? _compactBar(context)
              : PageColumn(
                  child: Row(
                    children: [
                      AppLink(
                        onPressed: () => _navigate(HomeSection.top),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
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

  Widget _compactBar(BuildContext context) {
    final colors = app.colors;
    final intl = context.intl.nav;
    final radius = app.dimensions.radius.s;
    final icons = app.assets.icons.actions;
    Widget section(String label, int number, HomeSection target) => AppLink(
      onPressed: () => _navigate(target),
      builder: (context, _) => Container(
        constraints: const BoxConstraints(minHeight: 52),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colors.surface.chip)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              number.toString().padLeft(2, '0'),
              style: AppText.meta.copyWith(color: colors.brand.signal),
            ),
          ],
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
          child: Row(
            children: [
              AppLink(
                onPressed: () => _navigate(HomeSection.top),
                builder: (context, _) => const SizedBox(
                  height: 44,
                  child: Root101Lockup(markWidth: 40, wordWidth: 72, gap: 10),
                ),
              ),
              const Spacer(),
              AppIconButton(
                tooltip: _menuOpen ? intl.closeMenu : intl.openMenu,
                onPressed: () => setState(() => _menuOpen = !_menuOpen),
                icon: (_menuOpen ? icons.close : icons.menu).build(
                  size: 20,
                  color: colors.text.primary,
                ),
              ),
            ],
          ),
        ),
        if (_menuOpen)
          Container(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colors.surface.stroke)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4,
              children: [
                section(intl.about, 1, HomeSection.about),
                section(intl.projects, 2, HomeSection.projects),
                section(intl.team, 3, HomeSection.team),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Row(
                    spacing: 10,
                    children: [
                      const LanguageWidget(),
                      Expanded(
                        child: AppButton(
                          label: intl.github,
                          url: Site.github,
                          icon: app.assets.icons.actions.github,
                          height: 48,
                          borderRadius: radius,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
