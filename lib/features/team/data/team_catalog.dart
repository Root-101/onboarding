import 'package:root101/app_exporter.dart';

/// The people of Root101, by hand. A new member is one more entry here: the
/// team section and the counter of the hero pick it up
abstract class TeamCatalog {
  // shortcut: the placeholders of the design until the real data is filled in
  static const List<MemberModel> members = [
    MemberModel(
      name: '[Tu nombre]',
      role: LocalizedText(
        en: 'founder · [your role]',
        es: 'fundador · [tu rol]',
      ),
      bio: LocalizedText(
        en: '[A line or two about you: what you like to build and why you started Root101.]',
        es: '[Una o dos líneas sobre ti: qué te gusta construir y por qué empezaste Root101.]',
      ),
      tags: ['winter', 'feather io', 'dumpling', 'maple'],
      github: 'Root-101',
    ),
  ];
}
