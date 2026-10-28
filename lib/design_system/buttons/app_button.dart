import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// `.r1-btn`: a button or a link styled as one. It lifts 2 px with an indigo
/// glow on hover (.2 s)
class AppButton extends StatelessWidget {
  final String label;
  final Uri? url;
  final VoidCallback? onPressed;
  final SvgAsset? icon;
  final SvgAsset? trailingIcon;
  final double height;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  final Color? background;
  final Color? borderColor;
  final Color? foreground;
  final double fontSize;
  final FontWeight fontWeight;
  final double iconSize;
  final double gap;

  /// Fills its parent's width (the stacked buttons of a project)
  final bool expand;

  const AppButton({
    required this.label,
    super.key,
    this.url,
    this.onPressed,
    this.icon,
    this.trailingIcon,
    this.height = 52,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.borderRadius,
    this.background,
    this.borderColor,
    this.foreground,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.iconSize = 18,
    this.gap = 10,
    this.expand = false,
  });

  /// Indigo, the main action
  const AppButton.primary({
    required String label,
    Key? key,
    Uri? url,
    VoidCallback? onPressed,
    SvgAsset? trailingIcon,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 24),
  }) : this(
         key: key,
         label: label,
         url: url,
         onPressed: onPressed,
         trailingIcon: trailingIcon,
         padding: padding,
       );

  /// Dark with a border, the second action
  factory AppButton.secondary({
    required String label,
    Key? key,
    Uri? url,
    VoidCallback? onPressed,
    SvgAsset? icon,
    double height = 52,
    double fontSize = 16,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 24),
    BorderRadius? borderRadius,
    Color? background,
  }) {
    final colors = app.colors;
    return AppButton(
      key: key,
      label: label,
      url: url,
      onPressed: onPressed,
      icon: icon,
      height: height,
      fontSize: fontSize,
      padding: padding,
      borderRadius: borderRadius,
      background: background ?? colors.surface.plateGlass,
      borderColor: colors.surface.stroke,
      foreground: colors.text.primary,
      fontWeight: FontWeight.w500,
      gap: 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final radius = borderRadius ?? app.dimensions.radius.m;
    final fg = foreground ?? colors.text.onBrand;
    final border = borderColor;
    return AppLink(
      url: url,
      onPressed: onPressed,
      borderRadius: radius,
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        height: height,
        padding: padding,
        transform: Matrix4.translationValues(0, hovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: background ?? colors.brand.indigo,
          borderRadius: radius,
          border: border == null ? null : Border.all(color: border),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 12),
              blurRadius: 32,
              color: colors.brand.indigo.withValues(alpha: hovered ? 0.45 : 0),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          spacing: gap,
          children: [
            if (icon case final icon?) icon.build(size: iconSize, color: fg),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: fg,
                ),
              ),
            ),
            if (trailingIcon case final icon?)
              icon.build(size: iconSize, color: fg),
          ],
        ),
      ),
    );
  }
}

/// A 44 px square with an icon (`.r1-tab`): its border lights on hover
class AppIconButton extends StatelessWidget {
  final Widget icon;
  final String tooltip;
  final VoidCallback onPressed;

  const AppIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final surface = app.colors.surface;
    final radius = app.dimensions.radius.s;
    return Semantics(
      button: true,
      label: tooltip,
      child: AppLink(
        onPressed: onPressed,
        borderRadius: radius,
        tooltip: tooltip,
        builder: (context, hovered) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: surface.plate,
            borderRadius: radius,
            border: Border.all(
              color: hovered ? surface.strokeHover : surface.stroke,
            ),
          ),
          child: icon,
        ),
      ),
    );
  }
}
