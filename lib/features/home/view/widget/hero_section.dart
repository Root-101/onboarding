import 'package:flutter/gestures.dart' show PointerHoverEvent;
import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The first screen: the pitch on the left, a terminal listing the projects on
/// the right, over a floor of light that runs towards the viewer. A spot of
/// indigo follows the mouse
class HeroSection extends StatefulWidget {
  final VoidCallback onSeeProjects;

  const HeroSection({required this.onSeeProjects, super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  /// Where the spot is before the mouse moves (72 %, 38 %). A notifier, so a
  /// mouse move repaints only the spot, not the whole hero
  final ValueNotifier<Alignment> _spot = ValueNotifier(
    const Alignment(0.44, -0.24),
  );

  void _follow(PointerHoverEvent event, Size size) {
    if (size.isEmpty) return;
    _spot.value = Alignment(
      event.localPosition.dx / size.width * 2 - 1,
      event.localPosition.dy / size.height * 2 - 1,
    );
  }

  @override
  void dispose() {
    _spot.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    if (context.isCompact) {
      return _CompactHero(onSeeProjects: widget.onSeeProjects);
    }
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.surface.stroke)),
      ),
      child: ClipRect(
        child: MouseRegion(
          onHover: (event) => _follow(event, context.size ?? Size.zero),
          child: Stack(
            children: [
              Positioned.fill(
                child: ValueListenableBuilder(
                  valueListenable: _spot,
                  builder: (context, at, _) => CustomPaint(
                    painter: SpotlightPainter(
                      at: at,
                      color: colors.brand.indigo.withValues(alpha: 0.22),
                    ),
                  ),
                ),
              ),
              const Positioned.fill(child: _Floor(height: 0.68)),
              Positioned(
                left: -120,
                top: 54,
                child: GlowOrb(
                  size: 520,
                  color: colors.brand.indigo.withValues(alpha: 0.35),
                  drift: const Duration(seconds: 14),
                ),
              ),
              Positioned(
                right: -140,
                top: 214,
                child: GlowOrb(
                  size: 460,
                  color: colors.brand.signal.withValues(alpha: 0.16),
                  drift: const Duration(seconds: 19),
                  reverse: true,
                ),
              ),
              PageColumn(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 152),
                child: LayoutBuilder(
                  builder: (context, column) {
                    // flex 1 1 460px and 1 1 420px, 56 apart: the free space
                    // is shared in halves
                    final extra = (column.maxWidth - 56 - 460 - 420) / 2;
                    return Row(
                      children: [
                        SizedBox(
                          width: 460 + extra,
                          child: _Pitch(onSeeProjects: widget.onSeeProjects),
                        ),
                        const SizedBox(width: 56),
                        SizedBox(width: 420 + extra, child: const _Console()),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The hero on a phone: everything in one column, the terminal last, and a
/// still spot (no mouse to follow)
class _CompactHero extends StatelessWidget {
  final VoidCallback onSeeProjects;

  const _CompactHero({required this.onSeeProjects});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.surface.stroke)),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: SpotlightPainter(
                  at: const Alignment(0.6, -0.64),
                  radius: 420,
                  color: colors.brand.indigo.withValues(alpha: 0.22),
                ),
              ),
            ),
            const Positioned.fill(child: _Floor(height: 0.4)),
            Positioned(
              left: -160,
              top: 40,
              child: GlowOrb(
                size: 360,
                color: colors.brand.indigo.withValues(alpha: 0.32),
                drift: const Duration(seconds: 14),
              ),
            ),
            PageColumn(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 72),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 28,
                children: [
                  _Pitch(onSeeProjects: onSeeProjects),
                  AppTerminal(
                    title: '~/root101',
                    command: 'root101 ls --projects',
                    lines: _Console.lines,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// `.r1-floor` placed like the design: twice as wide as the section,
/// [height] of it tall and 8 % below its bottom
class _Floor extends StatelessWidget {
  final double height;

  const _Floor({required this.height});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) => Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -box.maxWidth / 2,
            width: box.maxWidth * 2,
            bottom: -box.maxHeight * 0.08,
            height: box.maxHeight * height,
            child: const PerspectiveFloor(),
          ),
        ],
      ),
    );
  }
}

class _Pitch extends StatelessWidget {
  final VoidCallback onSeeProjects;

  const _Pitch({required this.onSeeProjects});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final intl = context.intl.hero;
    final compact = context.isCompact;
    final titleSize = compact
        ? 46.0
        : AppText.clampVw(context, min: 48, vw: 7, max: 92);
    final statSize = compact ? 28.0 : 32.0;
    Widget stat(String value, String label, {Color? color}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: statSize,
            fontWeight: FontWeight.w700,
            letterSpacing: AppText.em(-0.03, statSize),
            color: color,
          ),
        ),
        Text(label, style: AppText.meta),
      ],
    );
    final projects = ProjectsCatalog.all.length;
    final members = TeamCatalog.members.length;
    final stats = [
      stat('$projects', intl.projects(n: projects)),
      stat('$members', intl.members(n: members)),
      stat('100%', intl.indie, color: colors.brand.signal),
    ];
    final buttons = [
      AppButton.primary(
        label: intl.seeProjects,
        onPressed: onSeeProjects,
        trailingIcon: app.assets.icons.actions.arrowDown,
      ),
      AppButton.secondary(label: 'github.com/Root-101', url: Site.github),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: compact ? 22 : 28,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 12 : 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: colors.surface.plateGlass,
            // two lines on a phone: a rounded box instead of a pill
            borderRadius: compact
                ? BorderRadius.circular(14)
                : app.dimensions.radius.pill,
            border: Border.all(color: colors.surface.stroke),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: compact
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Padding(
                padding: EdgeInsets.only(top: compact ? 4 : 0),
                child: const PulseDot(),
              ),
              Flexible(
                child: Text(
                  intl.badge,
                  style: AppText.meta.copyWith(
                    fontSize: compact ? 11 : 13,
                    height: compact ? 1.5 : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '${intl.title}\n'),
              TextSpan(
                text: intl.titleAccent,
                style: TextStyle(color: colors.brand.signal),
              ),
            ],
          ),
          style: TextStyle(
            fontSize: titleSize,
            height: 0.98,
            fontWeight: FontWeight.w700,
            letterSpacing: AppText.em(-0.05, titleSize),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            intl.description,
            style: TextStyle(
              fontSize: compact ? 17 : 19,
              height: 1.55,
              color: colors.text.secondary,
            ),
          ),
        ),
        if (compact) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: buttons,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colors.surface.stroke)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [for (final s in stats) Expanded(child: s)],
            ),
          ),
        ] else ...[
          Wrap(spacing: 12, runSpacing: 12, children: buttons),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(spacing: 32, children: stats),
          ),
        ],
      ],
    );
  }
}

/// The terminal listing the projects, with the mark spinning over its corner
class _Console extends StatelessWidget {
  const _Console();

  static List<TerminalLine> get lines => [
    for (final project in ProjectsCatalog.all)
      TerminalLine(name: project.slug, description: project.tagline),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppTerminal(
          title: '~/root101',
          command: 'root101 ls --projects',
          lines: lines,
        ),
        Positioned(
          right: -24,
          top: -64,
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.9,
              child: GlowShadow(
                color: app.colors.brand.indigo.withValues(alpha: 0.6),
                blur: 24,
                child: const Root101Mark(width: 150, spin: true),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
