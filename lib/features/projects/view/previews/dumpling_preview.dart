import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Dumpling: a backup flow of its canvas (source → settings → destination)
/// and the last run, in Dumpling's own palette
class DumplingPreview extends StatelessWidget {
  static const Color _background = Color(0xFF121019);
  static const Color _bar = Color(0xFF0D0C12);
  static const Color _node = Color(0xFF17151F);
  static const Color _border = Color(0xFF2C2939);
  static const Color _muted = Color(0xFF8C8A98);
  static const Color _violet = Color(0xFF9D8FD0);
  static const Color _amber = Color(0xFFE6B77E);
  static const Color _action = Color(0xFF5B4A9A);
  static const Color _success = Color(0xFF7FD49A);
  static const String _font = 'DMSans';

  const DumplingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final intl = context.intl.previews.dumpling;
    const white = Color(0xFFFFFFFF);
    return ColoredBox(
      color: _background,
      child: CustomPaint(
        painter: const DotGridPainter(
          color: Color(0x1AFFFFFF),
          spacing: 22,
          radius: 1.1,
        ),
        child: DefaultTextStyle(
          style: const TextStyle(fontFamily: _font, color: white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  color: _bar,
                  border: Border(bottom: BorderSide(color: _border)),
                ),
                child: Row(
                  children: [
                    app.assets.projects.dumpling.sized(width: 40, height: 28),
                    12.gap(),
                    Text(
                      intl.workspace,
                      style: const TextStyle(fontSize: 15, color: _muted),
                    ),
                    12.gap(),
                    Text(
                      intl.main,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _action,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        intl.runNow,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Node(
                        label: intl.source,
                        labelColor: _amber,
                        title: 'PostgreSQL',
                        subtitle: 'produccion · 5432',
                      ),
                      const FlowLine(width: 64, color: _violet),
                      _Node(
                        label: intl.settings,
                        labelColor: _violet,
                        title: intl.schedule,
                        subtitle: intl.keep,
                        selected: true,
                      ),
                      const FlowLine(width: 64, color: _violet),
                      _Node(
                        label: intl.destination,
                        labelColor: _violet,
                        title: 'S3',
                        subtitle: 'backups-db/postgres/',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: _node,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _border),
                ),
                child: Row(
                  spacing: 16,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        const StrokeIcon(
                          '<circle cx="12" cy="12" r="9"/><path d="M8 12.5l2.5 2.5L16 9.5"/>',
                          size: 18,
                          color: _success,
                        ),
                        Text(
                          intl.completed,
                          style: const TextStyle(fontSize: 14, color: _success),
                        ),
                      ],
                    ),
                    Text(
                      intl.completedMeta,
                      style: AppText.mono.copyWith(fontSize: 12, color: _muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Node extends StatelessWidget {
  final String label;
  final Color labelColor;
  final String title;
  final String subtitle;
  final bool selected;

  const _Node({
    required this.label,
    required this.labelColor,
    required this.title,
    required this.subtitle,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DumplingPreview._node,
        borderRadius: BorderRadius.circular(14),
        border: selected
            ? Border.all(color: DumplingPreview._violet, width: 1.5)
            : Border.all(color: DumplingPreview._border),
        boxShadow: [
          if (selected)
            const BoxShadow(color: Color(0x1F9D8FD0), spreadRadius: 4),
          const BoxShadow(
            offset: Offset(0, 16),
            blurRadius: 40,
            color: Color(0x66000000),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(
            label,
            style: AppText.mono.copyWith(
              fontSize: 11,
              letterSpacing: AppText.em(0.08, 11),
              color: labelColor,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: DumplingPreview._muted),
          ),
        ],
      ),
    );
  }
}
