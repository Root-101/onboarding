import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final style = TextStyle(fontSize: 14, color: colors.text.secondary);
    return Container(
      decoration: BoxDecoration(
        color: colors.surface.background,
        border: Border(top: BorderSide(color: colors.surface.stroke)),
      ),
      child: PageColumn(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                const Root101Lockup(markWidth: 34, wordWidth: 58, gap: 10),
                Text('· © ${Site.year}', style: style),
              ],
            ),
            Text(
              Site.domain,
              style: AppText.mono.copyWith(
                fontSize: 13,
                color: colors.text.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
