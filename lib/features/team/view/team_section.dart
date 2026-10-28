import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// "03 · Team": a card per member and an open seat at the end
class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final intl = context.intl.team;
    final compact = context.isCompact;
    return PageColumn(
      padding: compact
          ? const EdgeInsets.fromLTRB(0, 64, 0, 24)
          : const EdgeInsets.fromLTRB(0, 120, 0, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: compact ? 24 : 40,
        children: [
          SectionHeading(overline: intl.overline, title: intl.title),
          AutoFitGrid(
            minItemWidth: 300,
            gap: compact ? 16 : 20,
            children: [
              for (final member in TeamCatalog.members)
                _MemberCard(member: member),
              const _OpenSeatCard(),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final MemberModel member;

  const _MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final compact = context.isCompact;
    final nameSize = compact ? 21.0 : 24.0;
    return ConicRing(
      borderRadius: app.dimensions.radius.xxl,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: colors.surface.plate,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Stack(
          children: [
            // centered on the avatar and the name (28 + 42 - 40)
            const ScanLine(top: 30),
            Padding(
              padding: EdgeInsets.all(
                compact ? 22 : app.dimensions.padding.card,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: compact ? 18 : 20,
                children: [
                  Row(
                    spacing: compact ? 16 : 18,
                    children: [
                      _Avatar(path: member.avatar, size: compact ? 64 : 84),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              member.name,
                              style: TextStyle(
                                fontSize: nameSize,
                                fontWeight: FontWeight.w700,
                                letterSpacing: AppText.em(-0.02, nameSize),
                              ),
                            ),
                            Text(
                              member.role.of(context),
                              style: AppText.mono.copyWith(
                                fontSize: 13,
                                color: colors.brand.signal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(member.bio.of(context), style: AppText.body),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final tag in member.tags)
                        AppTag(
                          label: tag,
                          color: colors.text.soft,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 44),
                    child: AppTextLink(
                      label: 'GitHub · ${member.github}',
                      url: member.githubUrl,
                    ),
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

class _Avatar extends StatelessWidget {
  final String? path;
  final double size;

  const _Avatar({required this.size, this.path});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final photo = path;
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.brand.indigo, colors.brand.navy],
        ),
        boxShadow: [BoxShadow(color: colors.surface.chip, spreadRadius: 4)],
      ),
      child: photo == null
          ? app.assets.icons.actions.user.build(
              size: size * 0.47,
              color: colors.text.primary,
            )
          : Image.asset(photo, width: size, height: size, fit: BoxFit.cover),
    );
  }
}

/// The dashed card inviting to join
class _OpenSeatCard extends StatelessWidget {
  const _OpenSeatCard();

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final intl = context.intl.team;
    final compact = context.isCompact;
    final seat = compact ? 56.0 : 84.0;
    final titleSize = compact ? 21.0 : 24.0;
    return HoverCard(
      borderRadius: app.dimensions.radius.xxl,
      background: colors.surface.plateFaint,
      borderColor: colors.surface.strokeStrong,
      padding: EdgeInsets.all(compact ? 22 : app.dimensions.padding.card),
      borderBuilder: (color, child) =>
          DashedBorder(color: color, radius: 24, child: child),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: compact ? 12 : 16,
        children: [
          DashedBorder(
            color: colors.surface.strokeHover,
            radius: seat / 2,
            child: SizedBox.square(
              dimension: seat,
              child: Center(
                child: app.assets.icons.actions.add.build(
                  size: compact ? 24 : 32,
                  color: colors.brand.indigo,
                ),
              ),
            ),
          ),
          Text(
            intl.openTitle,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              letterSpacing: AppText.em(-0.02, titleSize),
            ),
          ),
          Text(intl.openDescription, style: AppText.body),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: AppTextLink(label: intl.openLink, url: Site.github),
          ),
        ],
      ),
    );
  }
}
