///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'messages.g.dart';

// Path: <root>
typedef AppMessagesEn = AppMessages; // ignore: unused_element

class AppMessages with BaseTranslations<AppMessagesLocale, AppMessages> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppMessagesLocale.build] is preferred.
  AppMessages({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppMessagesLocale, AppMessages>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       _meta =
           meta ??
           TranslationMetadata(
             locale: AppMessagesLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    _meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  final TranslationMetadata<AppMessagesLocale, AppMessages> _meta;
  @override
  TranslationMetadata<AppMessagesLocale, AppMessages> get $meta => _meta;

  /// Access flat map
  dynamic operator [](String key) => _meta.getTranslation(key);

  late final AppMessages _root = this; // ignore: unused_field

  AppMessages $copyWith({
    TranslationMetadata<AppMessagesLocale, AppMessages>? meta,
  }) => AppMessages(meta: meta ?? this.$meta);

  // Translations
  late final AppMessages$app$en app = AppMessages$app$en._(_root);
  late final AppMessages$nav$en nav = AppMessages$nav$en._(_root);
  late final AppMessages$hero$en hero = AppMessages$hero$en._(_root);
  late final AppMessages$about$en about = AppMessages$about$en._(_root);
  late final AppMessages$projects$en projects = AppMessages$projects$en._(
    _root,
  );
  late final AppMessages$team$en team = AppMessages$team$en._(_root);
  late final AppMessages$contact$en contact = AppMessages$contact$en._(_root);
}

// Path: app
class AppMessages$app$en {
  AppMessages$app$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Root101'
  String get name => 'Root101';

  /// en: 'Root101 · Software engineering, from the root'
  String get title => 'Root101 · Software engineering, from the root';
}

// Path: nav
class AppMessages$nav$en {
  AppMessages$nav$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'What we do'
  String get about => 'What we do';

  /// en: 'Projects'
  String get projects => 'Projects';

  /// en: 'Team'
  String get team => 'Team';

  /// en: 'GitHub'
  String get github => 'GitHub';

  /// en: 'Language: {name: String}'
  String language({required String name}) => 'Language: ${name}';

  /// en: 'Open menu'
  String get openMenu => 'Open menu';

  /// en: 'Close menu'
  String get closeMenu => 'Close menu';
}

// Path: hero
class AppMessages$hero$en {
  AppMessages$hero$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'making the world a better place, one open source project at a time'
  String get badge =>
      'making the world a better place, one open source project at a time';

  /// en: 'Software engineering,'
  String get title => 'Software engineering,';

  /// en: 'from the root.'
  String get titleAccent => 'from the root.';

  /// en: 'Root101 designs and builds tools for developers and apps for people. Open source software, built on solid foundations and made to last.'
  String get description =>
      'Root101 designs and builds tools for developers and apps for people. Open source software, built on solid foundations and made to last.';

  /// en: 'See projects'
  String get seeProjects => 'See projects';

  /// en: '(one) {project} (other) {projects}'
  String projects({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'project',
        other: 'projects',
      );

  /// en: '(one) {member} (other) {members}'
  String members({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'member',
        other: 'members',
      );

  /// en: 'indie'
  String get indie => 'indie';
}

// Path: about
class AppMessages$about$en {
  AppMessages$about$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: '01 · WHAT WE DO'
  String get overline => '01 · WHAT WE DO';

  /// en: 'Small pieces that do one thing, and do it well.'
  String get title => 'Small pieces that do one thing, and do it well.';

  /// en: 'No investors, no rush. We pick problems we know up close and solve them with care, from the backend to the screen.'
  String get description =>
      'No investors, no rush. We pick problems we know up close and solve them with care, from the backend to the screen.';
}

// Path: projects
class AppMessages$projects$en {
  AppMessages$projects$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: '02 · PROJECTS'
  String get overline => '02 · PROJECTS';

  /// en: 'What we are building.'
  String get title => 'What we are building.';

  /// en: 'Previous project'
  String get previous => 'Previous project';

  /// en: 'Next project'
  String get next => 'Next project';

  /// en: 'Pick a project'
  String get pick => 'Pick a project';
}

// Path: team
class AppMessages$team$en {
  AppMessages$team$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: '03 · TEAM'
  String get overline => '03 · TEAM';

  /// en: 'For now, few people, lots of ideas.'
  String get title => 'For now, few people, lots of ideas.';

  /// en: 'This seat is open'
  String get openTitle => 'This seat is open';

  /// en: 'Like building small, well-made things? Check out the repos, open an issue or write to us.'
  String get openDescription =>
      'Like building small, well-made things? Check out the repos, open an issue or write to us.';

  /// en: 'See repositories'
  String get openLink => 'See repositories';
}

// Path: contact
class AppMessages$contact$en {
  AppMessages$contact$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Let's build something'
  String get title => 'Let\'s build something';

  /// en: 'from the root.'
  String get titleAccent => 'from the root.';

  /// en: 'Ideas, bugs, collaborations or just saying hi: it all starts on GitHub.'
  String get description =>
      'Ideas, bugs, collaborations or just saying hi: it all starts on GitHub.';

  /// en: 'Go to GitHub'
  String get github => 'Go to GitHub';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on AppMessages {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'app.name' => 'Root101',
      'app.title' => 'Root101 · Software engineering, from the root',
      'nav.about' => 'What we do',
      'nav.projects' => 'Projects',
      'nav.team' => 'Team',
      'nav.github' => 'GitHub',
      'nav.language' => ({required String name}) => 'Language: ${name}',
      'nav.openMenu' => 'Open menu',
      'nav.closeMenu' => 'Close menu',
      'hero.badge' =>
        'making the world a better place, one open source project at a time',
      'hero.title' => 'Software engineering,',
      'hero.titleAccent' => 'from the root.',
      'hero.description' => 'Root101 designs and builds tools for developers and apps for people. Open source software, built on solid foundations and made to last.',
      'hero.seeProjects' => 'See projects',
      'hero.projects' =>
        ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'project',
              other: 'projects',
            ),
      'hero.members' =>
        ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'member',
              other: 'members',
            ),
      'hero.indie' => 'indie',
      'about.overline' => '01 · WHAT WE DO',
      'about.title' => 'Small pieces that do one thing, and do it well.',
      'about.description' => 'No investors, no rush. We pick problems we know up close and solve them with care, from the backend to the screen.',
      'projects.overline' => '02 · PROJECTS',
      'projects.title' => 'What we are building.',
      'projects.previous' => 'Previous project',
      'projects.next' => 'Next project',
      'projects.pick' => 'Pick a project',
      'team.overline' => '03 · TEAM',
      'team.title' => 'For now, few people, lots of ideas.',
      'team.openTitle' => 'This seat is open',
      'team.openDescription' => 'Like building small, well-made things? Check out the repos, open an issue or write to us.',
      'team.openLink' => 'See repositories',
      'contact.title' => 'Let\'s build something',
      'contact.titleAccent' => 'from the root.',
      'contact.description' => 'Ideas, bugs, collaborations or just saying hi: it all starts on GitHub.',
      'contact.github' => 'Go to GitHub',
      _ => null,
    };
  }
}
