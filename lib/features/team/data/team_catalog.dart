import 'package:root101/app_exporter.dart';

/// The people of Root101, by hand. A new member is one more entry here: the
/// team section and the counter of the hero pick it up
abstract class TeamCatalog {
  static const List<MemberModel> members = [
    MemberModel(
      name: 'Jesus Hernandez',
      role: LocalizedText(
        en: 'founder · everything',
        es: 'fundador · todo',
      ),
      // shortcut: placeholder bio, see ROADMAP.md
      bio: LocalizedText(
        en: 'From the first commit to the last deploy. If it ships under Root101, I had a hand in it.',
        es: 'Del primer commit al último deploy. Si sale con el nombre de Root101, pasó por mis manos.',
      ),
      tags: ['winter', 'feather io', 'dumpling', 'maple'],
      github: 'JesusHdez960717',
    ),
  ];
}
