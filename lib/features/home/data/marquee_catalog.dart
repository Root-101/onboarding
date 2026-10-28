import 'package:root101/app_exporter.dart';

/// A word of the marquee after the project names; [accent] in signal
class MarqueeTopic {
  final LocalizedText label;
  final bool accent;

  const MarqueeTopic(this.label, {this.accent = false});
}

/// The band under the hero: every project's name (from `ProjectsCatalog`),
/// then these topics. By hand
abstract class MarqueeCatalog {
  static const List<MarqueeTopic> topics = [
    MarqueeTopic(LocalizedText.same('BACKEND'), accent: true),
    MarqueeTopic(LocalizedText(en: 'STORAGE', es: 'ALMACENAMIENTO')),
    MarqueeTopic(LocalizedText.same('BACKUPS')),
    MarqueeTopic(LocalizedText(en: 'FINANCE', es: 'FINANZAS'), accent: true),
    MarqueeTopic(LocalizedText.same('WEB')),
    MarqueeTopic(LocalizedText(en: 'MOBILE', es: 'MÓVIL')),
  ];
}
