import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// A project of Root101. Everything the page shows of it comes from here: the
/// hero's terminal, the marquee, the counter and its tab in the projects
/// section. The list lives in `ProjectsCatalog`
class ProjectModel {
  /// Its name in the terminal (`root101 ls --projects`)
  final String slug;
  final String name;

  /// What it is, beside its name in the tab (`framework`, `app`)
  final String kind;

  /// Its line in the terminal. In English in every language, like any CLI
  /// output (and it fits the terminal's width)
  final String tagline;

  final LocalizedText description;
  final List<LocalizedText> tags;

  /// Its logo in the bar of the preview window, in its own colors
  final SvgAsset logo;

  /// Title of the preview window (`winter · lib/main.dart`)
  final LocalizedText windowTitle;

  /// A screen of the project inside the preview window (540 px tall)
  final WidgetBuilder preview;

  /// Text links under the description (pub.dev, the repo)
  final List<ProjectLink> links;

  /// Full-width buttons under the description (the stores of an app)
  final List<ProjectButton> buttons;

  const ProjectModel({
    required this.slug,
    required this.name,
    required this.kind,
    required this.tagline,
    required this.description,
    required this.tags,
    required this.logo,
    required this.windowTitle,
    required this.preview,
    this.links = const [],
    this.buttons = const [],
  });
}

class ProjectLink {
  final String label;
  final Uri url;

  const ProjectLink({required this.label, required this.url});
}

class ProjectButton {
  final LocalizedText label;
  final SvgAsset icon;

  /// Null: shown, not clickable yet (an app before it is published)
  final Uri? url;

  /// Indigo; the rest are dark
  final bool primary;

  const ProjectButton({
    required this.label,
    required this.icon,
    this.url,
    this.primary = false,
  });
}
