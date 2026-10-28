import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/link.dart';

/// Something to click: a real link to [url] (`<a href>` on the web, a new tab
/// for web pages) or an [onPressed] action. Neither: shown, not clickable.
/// [builder] gets whether the mouse is over it, for the `:hover` styles
class AppLink extends StatefulWidget {
  final Uri? url;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;
  final String? tooltip;
  final Widget Function(BuildContext context, bool hovered) builder;

  const AppLink({
    required this.builder,
    super.key,
    this.url,
    this.onPressed,
    this.borderRadius,
    this.tooltip,
  });

  @override
  State<AppLink> createState() => _AppLinkState();
}

class _AppLinkState extends State<AppLink> {
  bool _hovered = false;

  Widget _clickable(VoidCallback? onTap) {
    final transparent = app.colors.neutral.transparent;
    final link = InkWell(
      onTap: onTap,
      onHover: (hovered) => setState(() => _hovered = hovered),
      borderRadius: widget.borderRadius,
      hoverColor: transparent,
      highlightColor: transparent,
      splashColor: transparent,
      child: widget.builder(context, _hovered),
    );
    final tooltip = widget.tooltip;
    return tooltip == null ? link : Tooltip(message: tooltip, child: link);
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.url;
    if (url != null) {
      return Link(
        uri: url,
        target: url.isScheme('http') || url.isScheme('https')
            ? LinkTarget.blank
            : LinkTarget.self,
        builder: (context, followLink) => _clickable(followLink),
      );
    }
    if (widget.onPressed != null) return _clickable(widget.onPressed);
    return widget.builder(context, false);
  }
}

/// A link in signal with `↗` (lighter on hover)
class AppTextLink extends StatelessWidget {
  final String label;
  final Uri url;
  final double fontSize;

  const AppTextLink({
    required this.label,
    required this.url,
    super.key,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    final brand = app.colors.brand;
    return AppLink(
      url: url,
      builder: (context, hovered) => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 40),
        child: Align(
          alignment: Alignment.centerLeft,
          widthFactor: 1,
          child: Text(
            '$label ↗',
            style: TextStyle(
              fontSize: fontSize,
              color: hovered ? brand.signalHover : brand.signal,
            ),
          ),
        ),
      ),
    );
  }
}
