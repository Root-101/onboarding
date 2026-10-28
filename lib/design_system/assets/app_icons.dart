import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

/// Stroke icons of the design (24x24 viewBox), one class per folder of
/// `assets/icons/`
class AppIcons {
  const AppIcons();

  final ActionsIcons actions = const ActionsIcons();
  final SectionsIcons sections = const SectionsIcons();
  final LanguageIcons language = const LanguageIcons();
}

class LanguageIcons {
  const LanguageIcons();

  static const String _language = 'assets/icons/languages';

  SvgAsset get es => const SvgAsset('$_language/es.svg');

  SvgAsset get en => const SvgAsset('$_language/en.svg');
}

/// The tiles of "what we do"
class SectionsIcons {
  const SectionsIcons();

  static const String _sections = 'assets/icons/sections';

  SvgAsset get code => const SvgAsset('$_sections/code.svg');

  SvgAsset get database => const SvgAsset('$_sections/database.svg');

  SvgAsset get phone => const SvgAsset('$_sections/phone.svg');
}

class ActionsIcons {
  const ActionsIcons();

  static const String _actions = 'assets/icons/actions';

  SvgAsset get github => const SvgAsset('$_actions/github.svg');

  SvgAsset get arrowDown => const SvgAsset('$_actions/arrow_down.svg');

  /// Points right; rotate it for the other directions
  SvgAsset get chevron => const SvgAsset('$_actions/chevron.svg');

  SvgAsset get add => const SvgAsset('$_actions/add.svg');

  SvgAsset get android => const SvgAsset('$_actions/android.svg');

  SvgAsset get globe => const SvgAsset('$_actions/globe.svg');

  SvgAsset get user => const SvgAsset('$_actions/user.svg');

  /// The header's menu on a phone, open and closed
  SvgAsset get menu => const SvgAsset('$_actions/menu.svg');

  SvgAsset get close => const SvgAsset('$_actions/close.svg');
}

class SvgAsset {
  final double defaultSvgSize = 24.0;

  final String url;
  final Color? defaultColor;
  final double? defaultSize;

  const SvgAsset(this.url, {this.defaultColor, this.defaultSize});

  Widget build({double? size, Color? color, BoxFit? fit}) => SvgPicture.asset(
    url,
    width: size ?? defaultSize ?? defaultSvgSize,
    height: size ?? defaultSize ?? defaultSvgSize,
    fit: fit ?? BoxFit.fill,
    colorFilter: (color ?? defaultColor) != null
        ? ColorFilter.mode((color ?? defaultColor)!, BlendMode.srcIn)
        : null,
  );

  /// A logo at its own aspect ratio: give one side, or both to fit inside
  Widget sized({double? width, double? height}) =>
      SvgPicture.asset(url, width: width, height: height, fit: BoxFit.contain);
}
