import 'package:root101/app_exporter.dart';

/// A kind of work Root101 does: a card of "what we do"
class AboutItemModel {
  final SvgAsset icon;
  final LocalizedText title;
  final LocalizedText description;

  const AboutItemModel({
    required this.icon,
    required this.title,
    required this.description,
  });
}
