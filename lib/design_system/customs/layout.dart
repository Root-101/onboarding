import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The page column: centered, at most [AppLayout.maxWidth] of content with the
/// gutters outside it (CSS `max-width` with `content-box`)
class PageColumn extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;

  /// A narrower column (the contact section)
  final double? maxWidth;

  const PageColumn({
    required this.child,
    super.key,
    this.padding = EdgeInsets.zero,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final layout = app.dimensions.layout;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (maxWidth ?? layout.maxWidth) + 2 * layout.gutter,
        ),
        child: Padding(
          padding: padding.add(EdgeInsets.symmetric(horizontal: layout.gutter)),
          child: child,
        ),
      ),
    );
  }
}

/// CSS `grid-template-columns: repeat(auto-fit, minmax([minItemWidth], 1fr))`:
/// as many columns as fit, never more than the items, all of a row as tall
/// as its tallest
class AutoFitGrid extends StatelessWidget {
  final double minItemWidth;
  final double gap;
  final List<Widget> children;

  const AutoFitGrid({
    required this.minItemWidth,
    required this.gap,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final fit = ((box.maxWidth + gap) / (minItemWidth + gap)).floor();
        final columns = fit.clamp(1, children.isEmpty ? 1 : children.length);
        final rows = <Widget>[
          for (var i = 0; i < children.length; i += columns)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: gap,
                children: [
                  for (var j = i; j < i + columns; j++)
                    Expanded(
                      child: j < children.length
                          ? children[j]
                          : const SizedBox.shrink(),
                    ),
                ],
              ),
            ),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: gap,
          children: rows,
        );
      },
    );
  }
}

/// The label and the title on top of every section, with an optional
/// [trailing] at the bottom right (a lead text, the arrows)
class SectionHeading extends StatelessWidget {
  final String overline;
  final String title;
  final double? titleMaxWidth;
  final Widget? trailing;

  const SectionHeading({
    required this.overline,
    required this.title,
    super.key,
    this.titleMaxWidth,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final heading = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: titleMaxWidth ?? double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(overline, style: AppText.overline),
          Text(title, style: AppText.sectionTitle(context)),
        ],
      ),
    );
    final end = trailing;
    if (end == null) return heading;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 24,
      children: [
        Flexible(child: heading),
        end,
      ],
    );
  }
}

/// A pill of mono text: a project's tags, a member's projects
class AppTag extends StatelessWidget {
  final String label;
  final Color? color;
  final EdgeInsets padding;

  const AppTag({
    required this.label,
    super.key,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: app.colors.surface.chip,
        borderRadius: app.dimensions.radius.pill,
      ),
      child: Text(label, style: AppText.meta.copyWith(color: color)),
    );
  }
}

/// A square tile with an icon in signal ("what we do")
class IconTile extends StatelessWidget {
  final SvgAsset icon;

  const IconTile({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: app.colors.surface.chip,
        borderRadius: app.dimensions.radius.m,
      ),
      child: icon.build(size: 24, color: app.colors.brand.signal),
    );
  }
}
