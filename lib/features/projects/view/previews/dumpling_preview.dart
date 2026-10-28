import 'dart:math' as math;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Dumpling: its pipeline editor (sources → configs → destinations), drawn at
/// 1350x900 like the app and shown at 60 %, in Dumpling's own palette
class DumplingPreview extends StatelessWidget {
  static const double _width = 1350;
  static const double _height = 900;
  static const double _scale = 0.6;

  static const Color background = Color(0xFF121019);
  static const Color surface = Color(0xFF17151F);
  static const Color control = Color(0xFF2C2939);
  static const Color selected = Color(0xFF3B2F63);
  static const Color action = Color(0xFF5B4A9A);
  static const Color border = Color(0xFF4F4C5C);
  static const Color divider = Color(0x804F4C5C);
  static const Color wire = Color(0xFF6A6778);
  static const Color violet = Color(0xFF9D8FD0);
  static const Color amber = Color(0xFFE6B77E);
  static const Color grey2 = Color(0xFFE5E5E5);
  static const Color grey3 = Color(0xFFB0AEB8);
  static const Color grey4 = Color(0xFF8C8A98);
  static const Color white = Color(0xFFFFFFFF);
  static const Color logoTile = Color(0xFFF1EFF6);

  const DumplingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topLeft,
          minWidth: 0,
          minHeight: 0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: Transform.scale(
            scale: _scale,
            alignment: Alignment.topLeft,
            child: const SizedBox(
              width: _width,
              height: _height,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14,
                  height: 20 / 14,
                  color: white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Rail(),
                    Expanded(child: _Main()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget icon(
    String body, {
    double size = 20,
    Color color = grey3,
    double stroke = 1.75,
  }) => StrokeIcon(body, size: size, color: color, strokeWidth: stroke);

  /// A section label of the canvas (`SOURCES`)
  static TextStyle get label => const TextStyle(
    fontSize: 11,
    height: 1.3,
    letterSpacing: 1.2,
    fontWeight: FontWeight.w700,
    color: grey4,
  );
}

/// The app's rail: the workspace, its sections and sign out
class _Rail extends StatelessWidget {
  const _Rail();

  @override
  Widget build(BuildContext context) {
    Widget item(String body, {bool active = false, Widget? badge}) => Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? DumplingPreview.selected : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          DumplingPreview.icon(
            body,
            color: active ? DumplingPreview.white : DumplingPreview.grey3,
          ),
          if (badge != null) Positioned(right: -8, top: -8, child: badge),
        ],
      ),
    );
    return Container(
      width: 64,
      padding: const EdgeInsets.symmetric(vertical: 14),
      color: DumplingPreview.surface,
      child: Column(
        spacing: 8,
        children: [
          Container(
            width: 44,
            height: 44,
            margin: const EdgeInsets.only(bottom: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: DumplingPreview.border),
            ),
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: DumplingPreview.action,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Text(
                'P',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          item(
            '<path d="M3.5 12a8.5 8.5 0 1 0 2.6-6.1L3.5 8.5"/><path d="M3.5 3.5v5h5"/><path d="M12 7.5V12l3 2"/>',
          ),
          item(
            '<circle cx="6" cy="6" r="2.5"/><circle cx="18" cy="18" r="2.5"/><path d="M8.5 6H14a4 4 0 0 1 4 4v5.5"/>',
            active: true,
          ),
          item(
            '<ellipse cx="12" cy="5.5" rx="7" ry="2.5"/><path d="M5 5.5v13c0 1.4 3.1 2.5 7 2.5s7-1.1 7-2.5v-13"/><path d="M5 12c0 1.4 3.1 2.5 7 2.5s7-1.1 7-2.5"/>',
          ),
          item(
            '<path d="M3.5 7h17"/><path d="M5 7l1.5 12.1A2 2 0 0 0 8.5 21h7a2 2 0 0 0 2-1.9L19 7"/><path d="M8 7a4 4 0 0 1 8 0"/>',
          ),
          item(
            '<path d="M3 12h4l3-8 4 16 3-8h4"/>',
            badge: Container(
              height: 16,
              constraints: const BoxConstraints(minWidth: 16),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: DumplingPreview.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '2',
                style: TextStyle(
                  fontSize: 10,
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                  color: DumplingPreview.background,
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: item(
              '<path d="M14 4h4a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2h-4"/><path d="M10 16l-4-4 4-4"/><path d="M6 12h10"/>',
            ),
          ),
        ],
      ),
    );
  }
}

/// The header (where, and the pipeline actions) over the canvas
class _Main extends StatelessWidget {
  const _Main();

  @override
  Widget build(BuildContext context) {
    Widget button(String label, Color color, {bool bold = false}) => Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: bold ? 20 : 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(fontWeight: bold ? FontWeight.w600 : FontWeight.w500),
      ),
    );
    return ColoredBox(
      color: DumplingPreview.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 64,
            padding: const EdgeInsets.fromLTRB(14, 10, 20, 10),
            child: Row(
              spacing: 16,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Production',
                              style: TextStyle(
                                color: DumplingPreview.grey4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' › ',
                              style: TextStyle(
                                color: DumplingPreview.border,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(text: 'Canvas'),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          height: 28 / 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Connect sources to destinations to build this workspace’s backups.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 18 / 13,
                          color: DumplingPreview.grey4,
                        ),
                      ),
                    ],
                  ),
                ),
                button('Test run', DumplingPreview.control),
                button('Save pipeline', DumplingPreview.action, bold: true),
              ],
            ),
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: DumplingPreview.background,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
                border: Border(
                  top: BorderSide(color: Color(0xBF4F4C5C)),
                  left: BorderSide(color: Color(0xBF4F4C5C)),
                ),
              ),
              child: const _Canvas(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Job {
  final double x;
  final double y;
  final String name;
  final String cron;
  final String human;
  final String last;
  final String status;
  final Color statusColor;
  final String next;
  final String nextIn;

  const _Job(
    this.x,
    this.y,
    this.name,
    this.cron,
    this.human,
    this.last,
    this.status,
    this.statusColor,
    this.next,
    this.nextIn,
  );

  Offset get input => Offset(x, y + 76);

  Offset get output => Offset(x + 240, y + 76);
}

/// The canvas of the editor: two sources, their configs and the destinations,
/// wired, with the hints, the toolbar, the shortcuts and the view controls
class _Canvas extends StatelessWidget {
  const _Canvas();

  // positions of the design's world (1056x836)
  static const Offset _ordersOut = Offset(240, 174);
  static const Offset _usersOut = Offset(240, 344);
  static const Offset _ordersFolder = Offset(760, 175);
  static const Offset _usersFolder = Offset(760, 215);

  static const List<_Job> _jobs = [
    _Job(
      380,
      98,
      'Nightly full',
      '0 2 * * *',
      'Every day at 02:00 UTC',
      '20/Oct 02:06 AM UTC · 1.8 GB',
      'Success',
      Color(0xFF34B257),
      '21/Oct 02:00 AM UTC',
      'in 12 h',
    ),
    _Job(
      380,
      268,
      'Nightly',
      '30 2 * * *',
      'Every day at 02:30 UTC',
      '20/Oct 02:31 AM UTC · timeout',
      'Failed',
      Color(0xFFEC6A66),
      '21/Oct 02:30 AM UTC',
      'in 13 h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final logos = app.assets.projects;
    return CustomPaint(
      painter: const DotGridPainter(
        color: Color(0x1CFFFFFF),
        spacing: 22,
        radius: 1.15,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 40,
            top: 60,
            child: Text('SOURCES', style: DumplingPreview.label),
          ),
          Positioned(
            left: 380,
            top: 60,
            child: Text(
              'CONFIG · ONE PER CONNECTION',
              style: DumplingPreview.label,
            ),
          ),
          Positioned(
            left: 760,
            top: 60,
            child: Text('DESTINATIONS', style: DumplingPreview.label),
          ),
          // the hints of how to create a backup, and their dotted links
          const Positioned(
            left: 40,
            top: 760,
            child: _Hint(
              width: 200,
              color: Color(0xBFE6B77E),
              text: 'Drag from a source port',
              textColor: DumplingPreview.amber,
              dot: true,
            ),
          ),
          const Positioned(
            left: 380,
            top: 760,
            child: _Hint(
              width: 240,
              color: Color(0x999D8FD0),
              text: 'Config is created here',
              textColor: DumplingPreview.grey3,
            ),
          ),
          const Positioned(
            left: 760,
            top: 760,
            child: _Hint(
              width: 256,
              color: Color(0xBFE6B77E),
              text: 'Drop on a folder or bucket',
              textColor: DumplingPreview.amber,
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _WiresPainter(
                wires: [
                  (_ordersOut, _jobs[0].input),
                  (_jobs[0].output, _ordersFolder),
                  (_usersOut, _jobs[1].input),
                  (_jobs[1].output, _usersFolder),
                ],
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 130,
            child: _Source(
              name: 'orders-db',
              engine: 'PostgreSQL 16',
              size: '12.4 GB',
              logo: logos.postgresql,
            ),
          ),
          Positioned(
            left: 40,
            top: 300,
            child: _Source(
              name: 'users-db',
              engine: 'PostgreSQL 15',
              size: '3.1 GB',
              logo: logos.postgresql,
            ),
          ),
          for (final job in _jobs)
            Positioned(
              left: job.x,
              top: job.y,
              child: _Config(job: job),
            ),
          Positioned(
            left: 760,
            top: 88,
            child: _Destination(
              bucket: 'bucket-backups',
              provider: 'AWS S3 · us-east-1',
              folders: const [('/orders', '1 config'), ('/users', '1 config')],
              logo: logos.s3,
            ),
          ),
          Positioned(
            left: 760,
            top: 484,
            child: _Destination(
              bucket: 'cold-archive',
              provider: 'Cloudflare R2 · auto',
              folders: const [],
              logo: logos.s3,
            ),
          ),
          const Positioned(right: 16, top: 16, child: _AddToolbar()),
          const Positioned(left: 16, bottom: 16, child: _Shortcuts()),
          const Positioned(right: 16, bottom: 16, child: _ViewControls()),
        ],
      ),
    );
  }
}

/// The wires between the nodes (grey: nothing selected) and the dotted links
/// between the hints
class _WiresPainter extends CustomPainter {
  final List<(Offset, Offset)> wires;

  const _WiresPainter({required this.wires});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DumplingPreview.wire
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (final (a, b) in wires) {
      final dx = math.max(40.0, (b.dx - a.dx).abs() / 2);
      canvas.drawPath(
        Path()
          ..moveTo(a.dx, a.dy)
          ..cubicTo(a.dx + dx, a.dy, b.dx - dx, b.dy, b.dx, b.dy),
        paint,
      );
    }
    // `stroke-dasharray="2 5"` with round caps: dots 7 apart
    final hint = Paint()
      ..color = DumplingPreview.amber.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (final (from, to) in const [(246.0, 374.0), (626.0, 754.0)]) {
      drawDashedPath(
        canvas,
        Path()
          ..moveTo(from, 782)
          ..lineTo(to, 782),
        hint,
        dash: 2,
        gap: 5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WiresPainter oldDelegate) => false;
}

/// A port: a ring on the edge of a node
class _Port extends StatelessWidget {
  final double size;
  final Color ring;

  const _Port({required this.size, this.ring = DumplingPreview.wire});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: DumplingPreview.background,
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: 2),
      ),
    );
  }
}

BoxDecoration _node() => BoxDecoration(
  color: DumplingPreview.surface,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: DumplingPreview.border),
  boxShadow: const [
    BoxShadow(offset: Offset(0, 6), blurRadius: 18, color: Color(0x47000000)),
  ],
);

Widget _logoTile(SvgAsset logo) => Container(
  width: 30,
  height: 30,
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: DumplingPreview.logoTile,
    borderRadius: BorderRadius.circular(8),
  ),
  child: logo.build(size: 17),
);

class _Source extends StatelessWidget {
  final String name;
  final String engine;
  final String size;
  final SvgAsset logo;

  const _Source({
    required this.name,
    required this.engine,
    required this.size,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 88,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 200,
            height: 88,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: _node(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    _logoTile(logo),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            height: 19 / 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          engine,
                          style: const TextStyle(
                            fontSize: 11,
                            height: 15 / 11,
                            color: DumplingPreview.grey4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  size,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 15 / 11,
                    color: DumplingPreview.grey3,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(right: -9, top: 35, child: _Port(size: 18)),
        ],
      ),
    );
  }
}

class _Config extends StatelessWidget {
  final _Job job;

  const _Config({required this.job});

  @override
  Widget build(BuildContext context) {
    const meta = TextStyle(fontSize: 11, height: 16 / 11);
    Widget line(Widget mark, String label, String value, Widget end) => Row(
      spacing: 6,
      children: [
        mark,
        Text(label, style: meta.copyWith(color: DumplingPreview.grey4)),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: meta.copyWith(color: DumplingPreview.grey2),
          ),
        ),
        end,
      ],
    );
    return SizedBox(
      width: 240,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: _node(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                  child: Row(
                    spacing: 10,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0x249D8FD0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DumplingPreview.icon(
                          '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
                          size: 16,
                          color: DumplingPreview.violet,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: Text(
                                    job.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: DumplingPreview.control,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    job.cron,
                                    style: AppText.mono.copyWith(
                                      fontSize: 11,
                                      height: 1.2,
                                      color: DumplingPreview.grey2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              job.human,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                height: 15 / 11,
                                color: DumplingPreview.grey4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: DumplingPreview.divider),
                    ),
                  ),
                  child: Column(
                    spacing: 6,
                    children: [
                      line(
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: job.statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        'Last',
                        job.last,
                        Text(
                          job.status,
                          style: meta.copyWith(
                            color: job.statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      line(
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: DumplingPreview.violet,
                              width: 1.5,
                            ),
                          ),
                        ),
                        'Next',
                        job.next,
                        Text(
                          job.nextIn,
                          style: meta.copyWith(color: DumplingPreview.grey4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(left: -6, top: 70, child: _Port(size: 12)),
          const Positioned(right: -9, top: 67, child: _Port(size: 18)),
        ],
      ),
    );
  }
}

class _Destination extends StatelessWidget {
  final String bucket;
  final String provider;

  /// (path, meta); none: it writes to the bucket root
  final List<(String, String)> folders;
  final SvgAsset logo;

  const _Destination({
    required this.bucket,
    required this.provider,
    required this.folders,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      decoration: _node(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: DumplingPreview.divider),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                if (folders.isEmpty)
                  const Positioned(
                    left: -21,
                    top: 24,
                    child: _Port(size: 12, ring: DumplingPreview.grey4),
                  ),
                Row(
                  spacing: 10,
                  children: [
                    _logoTile(logo),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bucket,
                          style: const TextStyle(
                            height: 19 / 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          provider,
                          style: const TextStyle(
                            fontSize: 11,
                            height: 15 / 11,
                            color: DumplingPreview.grey4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (path, meta) in folders)
                  SizedBox(
                    height: 40,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Positioned(
                          left: -7,
                          top: 14,
                          child: _Port(size: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            spacing: 8,
                            children: [
                              DumplingPreview.icon(
                                '<path d="M4 7h6l2 2h8v9a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1z"/>',
                                size: 15,
                                color: DumplingPreview.grey4,
                              ),
                              Expanded(
                                child: Text(
                                  path,
                                  style: AppText.mono.copyWith(
                                    fontSize: 12,
                                    color: DumplingPreview.grey2,
                                  ),
                                ),
                              ),
                              Text(
                                meta,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: DumplingPreview.grey4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (folders.isEmpty)
                  const SizedBox(
                    height: 30,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'No folders · writes to the bucket root',
                          style: TextStyle(
                            fontSize: 11,
                            color: DumplingPreview.grey4,
                          ),
                        ),
                      ),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 2),
                  child: DashedBorder(
                    color: DumplingPreview.border,
                    strokeWidth: 1,
                    radius: 8,
                    dash: 3,
                    gap: 3,
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          '+ Add folder',
                          style: TextStyle(
                            fontSize: 12,
                            color: DumplingPreview.grey3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A hint box of the canvas, with a dotted border
class _Hint extends StatelessWidget {
  final double width;
  final Color color;
  final String text;
  final Color textColor;
  final bool dot;

  const _Hint({
    required this.width,
    required this.color,
    required this.text,
    required this.textColor,
    this.dot = false,
  });

  @override
  Widget build(BuildContext context) {
    return DashedBorder(
      color: color,
      strokeWidth: 2,
      radius: 10,
      dash: 2,
      gap: 3,
      child: SizedBox(
        width: width,
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            if (dot)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: DumplingPreview.amber,
                  shape: BoxShape.circle,
                ),
              ),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: textColor == DumplingPreview.amber
                    ? FontWeight.w500
                    : FontWeight.w400,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Add a database or a destination, top right
class _AddToolbar extends StatelessWidget {
  const _AddToolbar();

  @override
  Widget build(BuildContext context) {
    Widget button(String icon, Color color, String label) => Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        spacing: 7,
        children: [
          DumplingPreview.icon(icon, size: 15, color: color),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: DumplingPreview.grey2),
          ),
        ],
      ),
    );
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xF017151F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: DumplingPreview.border),
      ),
      child: Row(
        spacing: 4,
        children: [
          button(
            '<ellipse cx="12" cy="5.5" rx="7" ry="2.5"/><path d="M5 5.5v13c0 1.4 3.1 2.5 7 2.5s7-1.1 7-2.5v-13"/>',
            const Color(0xFF8AA8FF),
            'Database',
          ),
          button(
            '<path d="M3.5 7h17"/><path d="M5 7l1.5 12.1A2 2 0 0 0 8.5 21h7a2 2 0 0 0 2-1.9L19 7"/>',
            DumplingPreview.amber,
            'Destination',
          ),
        ],
      ),
    );
  }
}

/// The shortcuts panel, bottom left
class _Shortcuts extends StatelessWidget {
  const _Shortcuts();

  static const List<(String, List<String>, String)> _rows = [
    ('Move canvas', ['Space'], '+ drag'),
    ('Move canvas', [], 'drag background'),
    ('Zoom', ['Ctrl'], '+ scroll'),
    ('Zoom in / out', ['+', '−'], ''),
    ('Center canvas', ['F'], ''),
    ('Reset to 100%', ['0'], ''),
    ('Close config', ['Esc'], ''),
    ('Show / hide shortcuts', ['?'], ''),
  ];

  @override
  Widget build(BuildContext context) {
    const text = TextStyle(fontSize: 12, height: 1.3);
    Widget key(String k) => Container(
      constraints: const BoxConstraints(minWidth: 26),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: DumplingPreview.control,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        k,
        style: AppText.mono.copyWith(
          fontSize: 11,
          height: 1.3,
          color: DumplingPreview.grey2,
        ),
      ),
    );
    return Container(
      width: 268,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xF517151F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: DumplingPreview.border),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 16,
            color: Color(0x59000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SHORTCUTS',
                  style: DumplingPreview.label.copyWith(
                    color: DumplingPreview.violet,
                  ),
                ),
                SizedBox.square(
                  dimension: 28,
                  child: Center(
                    child: DumplingPreview.icon(
                      '<path d="M6 6l12 12M18 6L6 18"/>',
                      size: 14,
                      stroke: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (final (label, keys, after) in _rows)
            SizedBox(
              height: 23,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: text.copyWith(color: DumplingPreview.grey3),
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      for (final k in keys) key(k),
                      if (after.isNotEmpty)
                        Text(
                          after,
                          style: text.copyWith(color: DumplingPreview.grey4),
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Settings, shortcuts, center and zoom, bottom right
class _ViewControls extends StatelessWidget {
  const _ViewControls();

  @override
  Widget build(BuildContext context) {
    const side = BorderSide(color: DumplingPreview.border);
    Widget cell(
      Widget child, {
      double? width,
      bool left = true,
      Color? color,
    }) => Container(
      width: width,
      height: 36,
      padding: width == null
          ? const EdgeInsets.symmetric(horizontal: 12)
          : EdgeInsets.zero,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        border: left ? const Border(left: side) : null,
      ),
      child: child,
    );
    const symbol = TextStyle(fontSize: 16, color: DumplingPreview.grey2);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: DumplingPreview.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: DumplingPreview.border),
      ),
      child: Row(
        children: [
          cell(
            DumplingPreview.icon(
              '<path d="M4 7h10M18 7h2M4 17h4M12 17h8"/><circle cx="16" cy="7" r="2"/><circle cx="10" cy="17" r="2"/>',
              size: 16,
              color: DumplingPreview.grey2,
            ),
            width: 36,
            left: false,
          ),
          cell(
            DumplingPreview.icon(
              '<rect x="2.5" y="6" width="19" height="12" rx="2"/><path d="M6.5 10h.01M10 10h.01M13.5 10h.01M17 10h.01M8 14h8"/>',
              size: 17,
              color: DumplingPreview.grey2,
            ),
            width: 36,
            color: DumplingPreview.selected,
          ),
          cell(
            Row(
              spacing: 6,
              children: [
                DumplingPreview.icon(
                  '<path d="M4 9V4h5M20 9V4h-5M4 15v5h5M20 15v5h-5"/><circle cx="12" cy="12" r="2"/>',
                  size: 14,
                  color: DumplingPreview.grey2,
                ),
                const Text(
                  'Center',
                  style: TextStyle(fontSize: 12, color: DumplingPreview.grey2),
                ),
              ],
            ),
          ),
          cell(const Text('−', style: symbol), width: 36),
          cell(
            const Text(
              '100%',
              style: TextStyle(fontSize: 12, color: DumplingPreview.grey3),
            ),
            width: 56,
          ),
          cell(const Text('+', style: symbol), width: 36),
        ],
      ),
    );
  }
}
