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
  /// Where the spot is before the mouse moves (72 %, 38 %)
  Alignment _spot = const Alignment(0.44, -0.24);

  void _follow(PointerHoverEvent event, Size size) {
    if (size.isEmpty) return;
    setState(
      () => _spot = Alignment(
        event.localPosition.dx / size.width * 2 - 1,
        event.localPosition.dy / size.height * 2 - 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
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
                child: CustomPaint(
                  painter: SpotlightPainter(
                    at: _spot,
                    color: colors.brand.indigo.withValues(alpha: 0.22),
                  ),
                ),
              ),
              const Positioned.fill(child: _Floor(height: 0.68)),
              Positioned(
                left: -120,
                top: 60,
                child: GlowOrb(
                  size: 520,
                  color: colors.brand.indigo.withValues(alpha: 0.35),
                  drift: const Duration(seconds: 14),
                ),
              ),
              Positioned(
                right: -140,
                top: 220,
                child: GlowOrb(
                  size: 460,
                  color: colors.brand.signal.withValues(alpha: 0.16),
                  drift: const Duration(seconds: 19),
                  reverse: true,
                ),
              ),
              PageColumn(
                padding: const EdgeInsets.fromLTRB(0, 112, 0, 152),
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
    final titleSize = AppText.clampVw(context, min: 48, vw: 7, max: 92);
    Widget stat(String value, String label, {Color? color}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: AppText.em(-0.03, 32),
            color: color,
          ),
        ),
        Text(label, style: AppText.meta),
      ],
    );
    final projects = ProjectsCatalog.all.length;
    final members = TeamCatalog.members.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 28,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: colors.surface.plateGlass,
            borderRadius: app.dimensions.radius.pill,
            border: Border.all(color: colors.surface.stroke),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              const PulseDot(),
              Flexible(
                child: Text(
                  intl.badge,
                  style: AppText.meta.copyWith(fontSize: 13),
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
              fontSize: 19,
              height: 1.55,
              color: colors.text.secondary,
            ),
          ),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            AppButton.primary(
              label: intl.seeProjects,
              onPressed: onSeeProjects,
              trailingIcon: app.assets.icons.actions.arrowDown,
            ),
            AppButton.secondary(label: 'github.com/Root-101', url: Site.github),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            spacing: 32,
            children: [
              stat('$projects', intl.projects(n: projects)),
              stat('$members', intl.members(n: members)),
              stat('100%', intl.indie, color: colors.brand.signal),
            ],
          ),
        ),
      ],
    );
  }
}

/// The terminal listing the projects, floating, with the mark spinning over
/// its corner
class _Console extends StatelessWidget {
  const _Console();

  @override
  Widget build(BuildContext context) {
    return Floating(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AppTerminal(
            title: '~/root101',
            command: 'root101 ls --projects',
            lines: [
              for (final project in ProjectsCatalog.all)
                TerminalLine(name: project.slug, description: project.tagline),
            ],
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
      ),
    );
  }
}
