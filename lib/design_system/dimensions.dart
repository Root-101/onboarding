import 'package:material_ui/material_ui.dart';

class AppDimensions {
  static final AppDimensions _instance = AppDimensions._internal();

  AppDimensions._internal();

  factory AppDimensions() => _instance;

  final AppRadius radius = const AppRadius();

  final AppPadding padding = const AppPadding();

  final AppLayout layout = const AppLayout();
}

class AppRadius {
  const AppRadius();

  /// 8.0: tooltips, the label of a window
  BorderRadius get xs => BorderRadius.circular(8);

  /// 12.0: small buttons (header, arrows)
  BorderRadius get s => BorderRadius.circular(12);

  /// 14.0: big buttons and icon tiles
  BorderRadius get m => BorderRadius.circular(14);

  /// 16.0: project tabs
  BorderRadius get l => BorderRadius.circular(16);

  /// 20.0: cards and the project preview
  BorderRadius get xl => BorderRadius.circular(20);

  /// 24.0: team cards
  BorderRadius get xxl => BorderRadius.circular(24);

  /// Pills and tags
  BorderRadius get pill => BorderRadius.circular(999);
}

class AppPadding {
  const AppPadding();

  /// 4.0
  double get xs => 4.0;

  /// 8.0
  double get s => 8.0;

  /// 12.0
  double get m => 12.0;

  /// 16.0
  double get l => 16.0;

  /// 20.0
  double get xl => 20.0;

  /// 24.0
  double get xxl => 24.0;

  /// 28.0: inside cards
  double get card => 28.0;
}

/// The page column of the design
class AppLayout {
  const AppLayout();

  /// Every section is centered in this width of content (gutters outside)
  double get maxWidth => 1200;

  /// Side padding of the page column
  double get gutter => 24;

  /// Side padding of the page column on a phone
  double get compactGutter => 20;
}
