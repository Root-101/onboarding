import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// "01 · What we do": the title, a lead and a card per kind of work
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final intl = context.intl.about;
    final colors = app.colors;
    if (context.isCompact) return const _CompactAbout();
    return PageColumn(
      padding: const EdgeInsets.fromLTRB(0, 120, 0, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 48,
        children: [
          SectionHeading(
            overline: intl.overline,
            title: intl.title,
            titleMaxWidth: 720,
            trailing: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Text(intl.description, style: AppText.lead),
            ),
          ),
          AutoFitGrid(
            minItemWidth: 280,
            gap: 20,
            children: [
              for (final item in AboutCatalog.items)
                HoverCard(
                  borderRadius: app.dimensions.radius.xl,
                  background: colors.surface.plate,
                  borderColor: colors.surface.stroke,
                  padding: EdgeInsets.all(app.dimensions.padding.card),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      IconTile(icon: item.icon),
                      Text(item.title.of(context), style: AppText.cardTitle),
                      Text(item.description.of(context), style: AppText.body),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// On a phone: the lead under the title, and a row per kind of work (the icon
/// beside its text)
class _CompactAbout extends StatelessWidget {
  const _CompactAbout();

  @override
  Widget build(BuildContext context) {
    final intl = context.intl.about;
    final colors = app.colors;
    return PageColumn(
      padding: const EdgeInsets.fromLTRB(0, 72, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 28,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14,
            children: [
              SectionHeading(overline: intl.overline, title: intl.title),
              Text(
                intl.description,
                style: AppText.lead.copyWith(fontSize: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              for (final item in AboutCatalog.items)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.surface.plate,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: colors.surface.stroke),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      IconTile(icon: item.icon, size: 44),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 6,
                          children: [
                            Text(
                              item.title.of(context),
                              style: AppText.cardTitle.copyWith(
                                fontSize: 19,
                                letterSpacing: AppText.em(-0.02, 19),
                              ),
                            ),
                            Text(
                              item.description.of(context),
                              style: AppText.body.copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
