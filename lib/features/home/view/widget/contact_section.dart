import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The closing call: the spinning mark over the floor of light, and GitHub
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final intl = context.intl.contact;
    final compact = context.isCompact;
    final titleSize = AppText.clampVw(context, min: 40, vw: 6, max: 76);
    final orb = compact ? 480.0 : 760.0;
    final buttons = [
      AppButton.primary(
        label: intl.github,
        url: Site.github,
        padding: const EdgeInsets.symmetric(horizontal: 26),
      ),
      AppButton.secondary(
        label: Site.contactEmail,
        url: Uri(scheme: 'mailto', path: Site.contactEmail),
        padding: const EdgeInsets.symmetric(horizontal: 26),
      ),
    ];
    return Container(
      margin: EdgeInsets.only(top: compact ? 56 : 100),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.surface.stroke)),
      ),
      child: ClipRect(
        child: Stack(
          children: [
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, box) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: -box.maxWidth / 2,
                      width: box.maxWidth * 2,
                      bottom: -box.maxHeight * 0.08,
                      height: box.maxHeight * (compact ? 0.7 : 0.9),
                      child: const Opacity(
                        opacity: 0.7,
                        child: PerspectiveFloor(),
                      ),
                    ),
                    // centered at 50 % / 40 % (38 % on a phone)
                    Positioned(
                      left: box.maxWidth / 2 - orb / 2,
                      top: box.maxHeight * (compact ? 0.38 : 0.4) - orb / 2,
                      child: GlowOrb(
                        size: orb,
                        fade: 0.62,
                        color: colors.brand.indigo.withValues(alpha: 0.30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PageColumn(
              maxWidth: 900,
              padding: compact
                  ? const EdgeInsets.fromLTRB(0, 80, 0, 96)
                  : const EdgeInsets.fromLTRB(0, 120, 0, 140),
              child: Column(
                spacing: compact ? 22 : 28,
                children: [
                  GlowShadow(
                    color: colors.brand.signal.withValues(alpha: 0.3),
                    blur: 30,
                    child: Root101Mark(width: compact ? 104 : 140, spin: true),
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleSize,
                      height: 1,
                      fontWeight: FontWeight.w700,
                      letterSpacing: AppText.em(-0.05, titleSize),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      intl.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: compact ? 16 : 18,
                        height: 1.55,
                        color: colors.text.secondary,
                      ),
                    ),
                  ),
                  if (compact)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 10,
                      children: buttons,
                    )
                  else
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: buttons,
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
