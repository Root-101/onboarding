import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Language selector of the header: the flag and code of the current
/// language, as the header's GitHub button; it opens a menu with the languages
class LanguageWidget extends CubitView<LanguageCubit> {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final radius = app.dimensions.radius.s;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Builder(
          builder: (anchor) => Semantics(
            button: true,
            label: context.intl.nav.language(name: state.current.name),
            child: AppLink(
              onPressed: () => _showMenu(anchor, state),
              borderRadius: radius,
              tooltip: context.intl.nav.language(name: state.current.name),
              builder: (context, hovered) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: colors.surface.plate,
                  borderRadius: radius,
                  border: Border.all(
                    color: hovered
                        ? colors.surface.strokeHover
                        : colors.surface.stroke,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: state.current.icon.build(size: 18),
                    ),
                    Text(
                      state.current.key.toUpperCase(),
                      style: AppText.mono.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: colors.text.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// The menu opens under the button
  void _showMenu(BuildContext anchor, LanguageState state) {
    final button = anchor.findRenderObject() as RenderBox;
    final overlay = Overlay.of(anchor).context.findRenderObject() as RenderBox;
    final bottomLeft = button.localToGlobal(
      button.size.bottomLeft(const Offset(0, 8)),
      ancestor: overlay,
    );
    final position = RelativeRect.fromRect(
      bottomLeft & Size(button.size.width, 0),
      Offset.zero & overlay.size,
    );
    final colors = app.colors;

    showMenu<String>(
      context: anchor,
      position: position,
      color: colors.surface.plate,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: app.dimensions.radius.s,
        side: BorderSide(color: colors.surface.stroke),
      ),
      items: [
        for (final language in state.allLanguages)
          PopupMenuItem(
            value: language.key,
            child: Row(
              spacing: 12,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: language.icon.build(size: 22),
                ),
                Text(
                  language.name,
                  style: TextStyle(
                    fontSize: 15,
                    color: colors.text.primary,
                    fontWeight: language == state.current
                        ? FontWeight.w700
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
      ],
    ).then((key) {
      if (key != null) cubit.changeLanguageKey(languageKey: key);
    });
  }
}
