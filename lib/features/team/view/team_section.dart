import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// "03 · Team": a card per member and an open seat at the end
class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final intl = context.intl.team;
    return PageColumn(
      padding: const EdgeInsets.fromLTRB(0, 120, 0, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 40,
        children: [
          SectionHeading(overline: intl.overline, title: intl.title),
          AutoFitGrid(
            minItemWidth: 300,
            gap: 20,
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
              padding: EdgeInsets.all(app.dimensions.padding.card),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Row(
                    spacing: 18,
                    children: [
                      _Avatar(path: member.avatar),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              member.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: AppText.em(-0.02, 24),
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

  const _Avatar({this.path});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final photo = path;
    return Container(
      width: 84,
      height: 84,
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
              size: 40,
              color: colors.text.primary,
            )
          : Image.asset(photo, width: 84, height: 84, fit: BoxFit.cover),
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
    return HoverCard(
      borderRadius: app.dimensions.radius.xxl,
      background: colors.surface.plateFaint,
      borderColor: colors.surface.strokeStrong,
      padding: EdgeInsets.all(app.dimensions.padding.card),
      borderBuilder: (color, child) =>
          DashedBorder(color: color, radius: 24, child: child),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          DashedBorder(
            color: colors.surface.strokeHover,
            radius: 42,
            child: SizedBox.square(
              dimension: 84,
              child: Center(
                child: app.assets.icons.actions.add.build(
                  size: 32,
                  color: colors.brand.indigo,
                ),
              ),
            ),
          ),
          Text(
            intl.openTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: AppText.em(-0.02, 24),
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
