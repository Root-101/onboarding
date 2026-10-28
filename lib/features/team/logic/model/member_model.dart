import 'package:root101/app_exporter.dart';

/// A person of Root101. The list lives in `TeamCatalog`; the hero counts it
class MemberModel {
  final String name;
  final LocalizedText role;
  final LocalizedText bio;

  /// What they work on (mono tags)
  final List<String> tags;

  /// Their GitHub user, without the `@`
  final String github;

  /// A photo under `assets/`; none, the default avatar
  final String? avatar;

  const MemberModel({
    required this.name,
    required this.role,
    required this.bio,
    required this.tags,
    required this.github,
    this.avatar,
  });

  Uri get githubUrl => Uri.parse('https://github.com/$github');
}
