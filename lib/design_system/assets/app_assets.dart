import 'package:root101/app_exporter.dart';

class AppAssets {
  static final AppAssets _instance = AppAssets._internal();

  AppAssets._internal();

  factory AppAssets() => _instance;

  final AppIcons icons = const AppIcons();

  final BrandAssets brand = const BrandAssets();

  final ProjectLogos projects = const ProjectLogos();
}

/// The Root101 mark, split so the gear can spin: [markGear] is a square
/// centered on the gear, [markBody] the two ones and the code
class BrandAssets {
  const BrandAssets();

  static const String _brand = 'assets/brand';

  SvgAsset get markBody => const SvgAsset('$_brand/mark_body.svg');

  SvgAsset get markGear => const SvgAsset('$_brand/mark_gear.svg');

  /// `root101`, the `101` in signal
  SvgAsset get wordmark => const SvgAsset('$_brand/wordmark.svg');
}

/// The logos of the projects, in their own colors
class ProjectLogos {
  const ProjectLogos();

  static const String _projects = 'assets/projects';

  SvgAsset get winter => const SvgAsset('$_projects/winter.svg');

  SvgAsset get featherIo => const SvgAsset('$_projects/feather_io.svg');

  SvgAsset get dumpling => const SvgAsset('$_projects/dumpling.svg');

  SvgAsset get maple => const SvgAsset('$_projects/maple.svg');

  /// Inside the Dumpling preview: a source and a destination
  SvgAsset get postgresql => const SvgAsset('$_projects/postgresql.svg');

  SvgAsset get s3 => const SvgAsset('$_projects/s3.svg');
}
