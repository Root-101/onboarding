import 'dart:async';

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// A terminal window typing [command] and its output, [lines], over and over
/// ([TerminalScript]). Its height fits every line from the start, so the page
/// never jumps while it types. With reduced motion it shows the whole output
class AppTerminal extends StatefulWidget {
  final String title;
  final String command;
  final List<TerminalLine> lines;

  const AppTerminal({
    required this.title,
    required this.command,
    required this.lines,
    super.key,
  });

  @override
  State<AppTerminal> createState() => _AppTerminalState();
}

class _AppTerminalState extends State<AppTerminal> {
  static const double _fontSize = 15;
  static const double _lineHeight = _fontSize * 2.2;

  late TerminalScript _script = _scriptOf(widget);
  Timer? _timer;
  int _tick = 0;

  static TerminalScript _scriptOf(AppTerminal w) =>
      TerminalScript(command: w.command, lines: w.lines);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer?.cancel();
    if (context.reduceMotion) {
      _tick = _script.typingEnd;
    } else {
      _timer = Timer.periodic(TerminalScript.tick, (_) {
        setState(() => _tick = (_tick + 1) % _script.length);
      });
    }
  }

  @override
  void didUpdateWidget(covariant AppTerminal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.command != widget.command ||
        oldWidget.lines != widget.lines) {
      _script = _scriptOf(widget);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final frame = _script.frameAt(_tick);
    final style = AppText.mono.copyWith(
      fontSize: _fontSize,
      height: 2.2,
      color: colors.text.primary,
    );
    final prompt = TextSpan(
      text: r'$ ',
      style: TextStyle(color: colors.brand.signal),
    );
    Widget line(List<InlineSpan> spans, {bool caret = false}) => Row(
      children: [
        Text.rich(TextSpan(children: spans), style: style, softWrap: false),
        if (caret) BlinkingCaret(style: style),
      ],
    );

    return WindowFrame(
      borderRadius: BorderRadius.circular(18),
      background: colors.surface.window.withValues(alpha: 0.92),
      shadows: [
        BoxShadow(
          offset: const Offset(0, 40),
          blurRadius: 120,
          color: colors.neutral.black.withValues(alpha: 0.6),
        ),
        BoxShadow(
          spreadRadius: 1,
          color: colors.brand.indigo.withValues(alpha: 0.08),
        ),
      ],
      title: Text(
        widget.title,
        style: AppText.mono.copyWith(
          fontSize: 13,
          color: colors.text.secondary,
        ),
      ),
      child: Container(
        // the command, every line and the `clear` prompt
        height: 22 + 26 + _lineHeight * (widget.lines.length + 2),
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 26),
        alignment: Alignment.topLeft,
        child: ClipRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              line([
                prompt,
                TextSpan(text: frame.command),
              ], caret: frame.typingCommand),
              for (final l in frame.lines)
                line([
                  TextSpan(text: l.name),
                  TextSpan(
                    text: l.description,
                    style: TextStyle(color: colors.text.secondary),
                  ),
                ]),
              if (frame.done)
                line([prompt, TextSpan(text: frame.clear)], caret: true),
            ],
          ),
        ),
      ),
    );
  }
}
