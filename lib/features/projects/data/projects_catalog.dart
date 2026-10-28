import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// The projects of Root101, by hand. A new project is one more entry here:
/// the terminal, the marquee, the counter of the hero and the projects section
/// pick it up. Its `preview` is a widget of `view/previews/`
abstract class ProjectsCatalog {
  static final List<ProjectModel> all = [
    ProjectModel(
      slug: 'winter',
      name: 'Winter',
      kind: 'framework',
      tagline: 'backend framework for Dart',
      description: const LocalizedText(
        en: 'Backend framework for Dart: routes, filters, validation and security. No annotations, no code generation.',
        es: 'Framework de backend para Dart: rutas, filtros, validación y seguridad. Sin anotaciones ni generación de código.',
      ),
      tags: const [
        LocalizedText.same('Dart'),
        LocalizedText.same('Backend'),
        LocalizedText.same('pub.dev'),
      ],
      logo: app.assets.projects.winter,
      windowTitle: const LocalizedText.same('winter · lib/main.dart'),
      preview: (_) => const WinterPreview(),
      // the code at ~10 px on a phone
      compactPreviewSize: const Size(470, 470),
      links: [
        ProjectLink(
          label: 'pub.dev/packages/winter',
          url: Uri.parse('https://pub.dev/packages/winter'),
        ),
        ProjectLink(
          label: 'Root-101/winter',
          url: Uri.parse('https://github.com/Root-101/winter'),
        ),
      ],
    ),
    ProjectModel(
      slug: 'feather-io',
      name: 'Feather IO',
      kind: 'storage',
      tagline: 'S3-compatible object storage',
      description: const LocalizedText(
        en: 'S3-compatible object storage, with a web console for buckets, files and access keys.',
        es: 'Almacenamiento de objetos compatible con S3, con una consola web para buckets, archivos y llaves de acceso.',
      ),
      tags: const [
        LocalizedText.same('S3'),
        LocalizedText(en: 'Storage', es: 'Almacenamiento'),
        LocalizedText(en: 'Web console', es: 'Consola web'),
      ],
      logo: app.assets.projects.featherIo,
      windowTitle: const LocalizedText(
        en: 'feather io · console',
        es: 'feather io · consola',
      ),
      preview: (_) => const FeatherIoPreview(),
      compactPreviewSize: const Size(760, 540),
      links: [
        ProjectLink(
          label: 'railway.com/deploy/feather-io',
          url: Uri.parse('https://railway.com/deploy/feather-io'),
        ),
        ProjectLink(
          label: 'Root-101/feather-io',
          url: Uri.parse('https://github.com/Root-101/feather-io'),
        ),
      ],
    ),
    ProjectModel(
      slug: 'dumpling',
      name: 'Dumpling',
      kind: 'backups',
      tagline: 'database backups to S3',
      description: const LocalizedText(
        en: 'Database backups to S3. You build each flow by dragging pieces: source, settings and destination.',
        es: 'Backups de bases de datos hacia S3. Armas cada flujo arrastrando piezas: origen, configuración y destino.',
      ),
      tags: const [
        LocalizedText.same('PostgreSQL'),
        LocalizedText.same('S3'),
        LocalizedText.same('Backups'),
      ],
      logo: app.assets.projects.dumpling,
      windowTitle: const LocalizedText(
        en: 'dump·ling · main workspace',
        es: 'dump·ling · workspace principal',
      ),
      preview: (_) => const DumplingPreview(),
      // the whole 1350x900 editor at 60 %
      compactPreviewSize: const Size(810, 540),
      links: [
        ProjectLink(
          label: 'Root-101/dumpling',
          url: Uri.parse('https://github.com/Root-101/dumpling'),
        ),
      ],
    ),
    ProjectModel(
      slug: 'maple',
      name: 'Maple',
      kind: 'app',
      tagline: 'personal finance · mobile + web',
      description: const LocalizedText(
        en: 'Personal finance on mobile and the web: accounts, operations, categories and upcoming payments.',
        es: 'Finanzas personales en el móvil y la web: cuentas, operaciones, categorías y próximos pagos.',
      ),
      tags: const [
        LocalizedText(en: 'Mobile', es: 'Móvil'),
        LocalizedText.same('Web'),
        LocalizedText(en: 'Finance', es: 'Finanzas'),
      ],
      logo: app.assets.projects.maple,
      windowTitle: const LocalizedText(
        en: 'maple · mobile & web',
        es: 'maple · móvil y web',
      ),
      preview: (context) => MaplePreview(compact: context.isCompact),
      compactPreviewSize: const Size(480, 540),
      buttons: [
        // shortcut: no store link yet, the button shows without one; set it when it is published
        ProjectButton(
          label: const LocalizedText.same('Android'),
          icon: app.assets.icons.actions.android,
          primary: true,
        ),
        ProjectButton(
          label: const LocalizedText.same('Web: maple.root101.dev →'),
          icon: app.assets.icons.actions.globe,
          url: Uri.parse('https://maple.root101.dev'),
        ),
      ],
    ),
  ];
}
