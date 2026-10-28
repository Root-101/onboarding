import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The band under the hero: the project names and the topics, scrolling
class MarqueeBand extends StatelessWidget {
  const MarqueeBand({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final compact = context.isCompact;
    final fontSize = compact ? 13.0 : 15.0;
    final style = AppText.mono.copyWith(
      fontSize: fontSize,
      letterSpacing: AppText.em(0.12, fontSize),
      color: colors.text.secondary,
    );
    final words = [
      for (final project in ProjectsCatalog.all)
        (project.name.toUpperCase(), false),
      for (final topic in MarqueeCatalog.topics)
        (topic.label.of(context), topic.accent),
    ];
    final slash = Text('/', style: style.copyWith(color: colors.brand.indigo));
    return ExcludeSemantics(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: compact ? 18 : 22),
        decoration: BoxDecoration(
          color: colors.surface.band,
          border: Border(bottom: BorderSide(color: colors.surface.stroke)),
        ),
        child: Marquee(
          gap: compact ? 28 : 40,
          duration: const Duration(seconds: 40),
          children: [
            for (final (word, accent) in words) ...[
              Text(
                word,
                style: accent
                    ? style.copyWith(color: colors.brand.signal)
                    : style,
              ),
              slash,
            ],
          ],
        ),
      ),
    );
  }
}
