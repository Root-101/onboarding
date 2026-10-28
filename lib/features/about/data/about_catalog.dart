import 'package:root101/app_exporter.dart';

/// The cards of "what we do", by hand
abstract class AboutCatalog {
  static final List<AboutItemModel> items = [
    AboutItemModel(
      icon: app.assets.icons.sections.code,
      title: const LocalizedText(
        en: 'Tools for devs',
        es: 'Herramientas para devs',
      ),
      description: const LocalizedText(
        en: 'Frameworks and libraries we would use ourselves. Today: Winter, backend for Dart.',
        es: 'Frameworks y librerías que usaríamos nosotros mismos. Hoy: Winter, backend para Dart.',
      ),
    ),
    AboutItemModel(
      icon: app.assets.icons.sections.database,
      title: const LocalizedText(
        en: 'Data infrastructure',
        es: 'Infraestructura de datos',
      ),
      description: const LocalizedText(
        en: 'Storing files and backing up databases without depending on anyone: Feather IO and Dumpling.',
        es: 'Guardar archivos y respaldar bases de datos sin depender de nadie: Feather IO y Dumpling.',
      ),
    ),
    AboutItemModel(
      icon: app.assets.icons.sections.phone,
      title: const LocalizedText(
        en: 'Apps for people',
        es: 'Apps para personas',
      ),
      description: const LocalizedText(
        en: 'Products for every day, on mobile and the web. Today: Maple, to keep your finances in order.',
        es: 'Productos para el día a día, en el móvil y la web. Hoy: Maple, para ordenar tus finanzas.',
      ),
    ),
  ];
}
