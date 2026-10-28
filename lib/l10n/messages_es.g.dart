///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'messages.g.dart';

import 'package:intl/intl.dart';
import 'package:slang/generated.dart';

// Path: <root>
class AppMessagesEs
    with BaseTranslations<AppMessagesLocale, AppMessages>
    implements AppMessages {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppMessagesLocale.build] is preferred.
  AppMessagesEs({
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
             locale: AppMessagesLocale.es,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    _meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <es>.
  final TranslationMetadata<AppMessagesLocale, AppMessages> _meta;
  @override
  TranslationMetadata<AppMessagesLocale, AppMessages> get $meta => _meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => _meta.getTranslation(key);

  late final AppMessagesEs _root = this; // ignore: unused_field

  @override
  AppMessagesEs $copyWith({
    TranslationMetadata<AppMessagesLocale, AppMessages>? meta,
  }) => AppMessagesEs(meta: meta ?? this.$meta);

  // Translations
  @override
  late final AppMessages$app$es app = AppMessages$app$es._(_root);
  @override
  late final AppMessages$nav$es nav = AppMessages$nav$es._(_root);
  @override
  late final AppMessages$hero$es hero = AppMessages$hero$es._(_root);
  @override
  late final AppMessages$about$es about = AppMessages$about$es._(_root);
  @override
  late final AppMessages$projects$es projects = AppMessages$projects$es._(
    _root,
  );
  @override
  late final AppMessages$team$es team = AppMessages$team$es._(_root);
  @override
  late final AppMessages$contact$es contact = AppMessages$contact$es._(_root);
  @override
  late final AppMessages$previews$es previews = AppMessages$previews$es._(
    _root,
  );
}

// Path: app
class AppMessages$app$es implements AppMessages$app$en {
  AppMessages$app$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Root101';
  @override
  String get needMoreSpace =>
      'Por ahora Root101 está pensado para pantallas de escritorio. Ábrelo en una ventana más ancha.';
}

// Path: nav
class AppMessages$nav$es implements AppMessages$nav$en {
  AppMessages$nav$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get about => 'Qué hacemos';
  @override
  String get projects => 'Proyectos';
  @override
  String get team => 'Equipo';
  @override
  String get github => 'GitHub';
  @override
  String language({required String name}) => 'Idioma: ${name}';
}

// Path: hero
class AppMessages$hero$es implements AppMessages$hero$en {
  AppMessages$hero$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get badge =>
      'making the world a better place, one open source project at a time';
  @override
  String get title => 'Ingeniería de software,';
  @override
  String get titleAccent => 'desde la raíz.';
  @override
  String get description =>
      'Root101 diseña y desarrolla herramientas para desarrolladores y aplicaciones para personas. Software de código abierto, construido con fundamentos sólidos y pensado para durar.';
  @override
  String get seeProjects => 'Ver proyectos';
  @override
  String projects({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'proyecto',
        other: 'proyectos',
      );
  @override
  String members({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'integrante',
        other: 'integrantes',
      );
  @override
  String get indie => 'indie';
}

// Path: about
class AppMessages$about$es implements AppMessages$about$en {
  AppMessages$about$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get overline => '01 · QUÉ HACEMOS';
  @override
  String get title => 'Piezas pequeñas que hacen una cosa, y la hacen bien.';
  @override
  String get description =>
      'Sin inversores ni prisa. Elegimos problemas que conocemos de cerca y los resolvemos con cuidado, del backend a la pantalla.';
}

// Path: projects
class AppMessages$projects$es implements AppMessages$projects$en {
  AppMessages$projects$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get overline => '02 · PROYECTOS';
  @override
  String get title => 'Lo que estamos construyendo.';
  @override
  String get previous => 'Proyecto anterior';
  @override
  String get next => 'Proyecto siguiente';
  @override
  String get pick => 'Elegir proyecto';
}

// Path: team
class AppMessages$team$es implements AppMessages$team$en {
  AppMessages$team$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get overline => '03 · EQUIPO';
  @override
  String get title => 'Por ahora, pocas personas, muchas ideas.';
  @override
  String get openTitle => 'Este lugar está libre';
  @override
  String get openDescription =>
      '¿Te gusta construir cosas pequeñas y bien hechas? Mira los repos, abre un issue o escríbenos.';
  @override
  String get openLink => 'Ver repositorios';
}

// Path: contact
class AppMessages$contact$es implements AppMessages$contact$en {
  AppMessages$contact$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Construyamos algo';
  @override
  String get titleAccent => 'desde la raíz.';
  @override
  String get description =>
      'Ideas, bugs, colaboraciones o simplemente saludar: todo empieza en GitHub.';
  @override
  String get github => 'Ir a GitHub';
  @override
  String get emailPlaceholder => '[correo de contacto]';
}

// Path: previews
class AppMessages$previews$es implements AppMessages$previews$en {
  AppMessages$previews$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  late final AppMessages$previews$dumpling$es dumpling =
      AppMessages$previews$dumpling$es._(_root);
}

// Path: previews.dumpling
class AppMessages$previews$dumpling$es
    implements AppMessages$previews$dumpling$en {
  AppMessages$previews$dumpling$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get workspace => 'Workspace';
  @override
  String get main => 'principal';
  @override
  String get runNow => 'Ejecutar ahora';
  @override
  String get source => 'ORIGEN';
  @override
  String get settings => 'CONFIGURACIÓN';
  @override
  String get destination => 'DESTINO';
  @override
  String get schedule => 'Cada día · 03:00';
  @override
  String get keep => 'Guardar 14 copias';
  @override
  String get completed => 'Backup completado';
  @override
  String get completedMeta => 'hoy 03:00:41 · 1.2 GB · 38 s';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on AppMessagesEs {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'app.name' => 'Root101',
      'app.needMoreSpace' => 'Por ahora Root101 está pensado para pantallas de escritorio. Ábrelo en una ventana más ancha.',
      'nav.about' => 'Qué hacemos',
      'nav.projects' => 'Proyectos',
      'nav.team' => 'Equipo',
      'nav.github' => 'GitHub',
      'nav.language' => ({required String name}) => 'Idioma: ${name}',
      'hero.badge' =>
        'making the world a better place, one open source project at a time',
      'hero.title' => 'Ingeniería de software,',
      'hero.titleAccent' => 'desde la raíz.',
      'hero.description' => 'Root101 diseña y desarrolla herramientas para desarrolladores y aplicaciones para personas. Software de código abierto, construido con fundamentos sólidos y pensado para durar.',
      'hero.seeProjects' => 'Ver proyectos',
      'hero.projects' =>
        ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'proyecto',
              other: 'proyectos',
            ),
      'hero.members' =>
        ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'integrante',
              other: 'integrantes',
            ),
      'hero.indie' => 'indie',
      'about.overline' => '01 · QUÉ HACEMOS',
      'about.title' => 'Piezas pequeñas que hacen una cosa, y la hacen bien.',
      'about.description' => 'Sin inversores ni prisa. Elegimos problemas que conocemos de cerca y los resolvemos con cuidado, del backend a la pantalla.',
      'projects.overline' => '02 · PROYECTOS',
      'projects.title' => 'Lo que estamos construyendo.',
      'projects.previous' => 'Proyecto anterior',
      'projects.next' => 'Proyecto siguiente',
      'projects.pick' => 'Elegir proyecto',
      'team.overline' => '03 · EQUIPO',
      'team.title' => 'Por ahora, pocas personas, muchas ideas.',
      'team.openTitle' => 'Este lugar está libre',
      'team.openDescription' => '¿Te gusta construir cosas pequeñas y bien hechas? Mira los repos, abre un issue o escríbenos.',
      'team.openLink' => 'Ver repositorios',
      'contact.title' => 'Construyamos algo',
      'contact.titleAccent' => 'desde la raíz.',
      'contact.description' => 'Ideas, bugs, colaboraciones o simplemente saludar: todo empieza en GitHub.',
      'contact.github' => 'Ir a GitHub',
      'contact.emailPlaceholder' => '[correo de contacto]',
      'previews.dumpling.workspace' => 'Workspace',
      'previews.dumpling.main' => 'principal',
      'previews.dumpling.runNow' => 'Ejecutar ahora',
      'previews.dumpling.source' => 'ORIGEN',
      'previews.dumpling.settings' => 'CONFIGURACIÓN',
      'previews.dumpling.destination' => 'DESTINO',
      'previews.dumpling.schedule' => 'Cada día · 03:00',
      'previews.dumpling.keep' => 'Guardar 14 copias',
      'previews.dumpling.completed' => 'Backup completado',
      'previews.dumpling.completedMeta' => 'hoy 03:00:41 · 1.2 GB · 38 s',
      _ => null,
    };
  }
}
