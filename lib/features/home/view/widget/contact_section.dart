import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The closing call: the spinning mark over the floor of light, and GitHub
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final intl = context.intl.contact;
    final titleSize = AppText.clampVw(context, min: 40, vw: 6, max: 76);
    return Container(
      margin: const EdgeInsets.only(top: 100),
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
                      height: box.maxHeight * 0.9,
                      child: const Opacity(
                        opacity: 0.7,
                        child: PerspectiveFloor(),
                      ),
                    ),
                    // centered at 50 % / 40 %
                    Positioned(
                      left: box.maxWidth / 2 - 380,
                      top: box.maxHeight * 0.4 - 380,
                      child: GlowOrb(
                        size: 760,
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
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 140),
              child: Column(
                spacing: 28,
                children: [
                  GlowShadow(
                    color: colors.brand.signal.withValues(alpha: 0.3),
                    blur: 30,
                    child: const Root101Mark(width: 140, spin: true),
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
                        fontSize: 18,
                        height: 1.55,
                        color: colors.text.secondary,
                      ),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
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
                    ],
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
