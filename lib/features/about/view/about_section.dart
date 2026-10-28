import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// "01 · What we do": the title, a lead and a card per kind of work
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final intl = context.intl.about;
    final colors = app.colors;
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
