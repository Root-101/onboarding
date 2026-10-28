import 'dart:math' as math;

/// One row of the output: a name and what it is
class TerminalLine {
  final String name;
  final String description;

  const TerminalLine({required this.name, required this.description});
}

/// One frame of [TerminalScript]: what the terminal shows at a tick
class TerminalFrame {
  /// The command typed so far
  final String command;

  /// The caret is still on the command line
  final bool typingCommand;

  /// Rows typed so far; the last one may be partial
  final List<TerminalLine> lines;

  /// Everything is out: the prompt with `clear` shows
  final bool done;

  /// `clear` typed so far on the last prompt
  final String clear;

  const TerminalFrame({
    required this.command,
    required this.typingCommand,
    required this.lines,
    required this.done,
    required this.clear,
  });
}

/// The typing of the hero's terminal, the script of the design: every
/// [tick] two characters appear, first [command], then each line (the name
/// padded to [nameWidth]). It holds three seconds, types `clear`, waits one
/// and starts over. Pure: a frame depends only on the tick
class TerminalScript {
  static const Duration tick = Duration(milliseconds: 55);
  static const int _charsPerTick = 2;

  /// Pause between the command and the first line, in characters
  static const int _commandPause = 10;

  /// Ticks: 3 s holding, `clear` (5 characters), 1 s before the restart
  static const int _hold = 55;
  static const int _clearTyping = 10;
  static const int _restart = 18;
  static const String _clear = 'clear';

  final String command;
  final List<TerminalLine> lines;

  /// Width of the name column, at least two spaces wider than any name
  final int nameWidth;

  TerminalScript({required this.command, required this.lines})
    : nameWidth = math.max(
        12,
        lines.fold(0, (w, l) => math.max(w, l.name.length)) + 2,
      );

  int get _typedChars =>
      command.length +
      _commandPause +
      lines.fold(0, (sum, l) => sum + nameWidth + l.description.length);

  /// The tick the last character is out
  int get typingEnd => (_typedChars / _charsPerTick).ceil();

  /// Ticks of a whole lap; then it starts over from 0
  int get length => typingEnd + _hold + _clearTyping + _restart;

  TerminalFrame frameAt(int tick) {
    var budget = tick * _charsPerTick;
    final shownCommand = command.substring(0, math.min(command.length, budget));
    final typingCommand = budget < command.length + 6;
    budget -= command.length + _commandPause;

    final shown = <TerminalLine>[];
    for (final line in lines) {
      final full = line.name.padRight(nameWidth) + line.description;
      final visible = budget.clamp(0, full.length);
      budget -= full.length;
      if (visible > 0) {
        shown.add(
          TerminalLine(
            name: full.substring(0, math.min(visible, nameWidth)),
            description: visible > nameWidth
                ? full.substring(nameWidth, visible)
                : '',
          ),
        );
      }
    }

    final clearStart = typingEnd + _hold;
    final clearChars = ((tick - clearStart) / 2).floor().clamp(
      0,
      _clear.length,
    );
    return TerminalFrame(
      command: shownCommand,
      typingCommand: typingCommand,
      lines: shown,
      done: budget > 0,
      clear: _clear.substring(0, clearChars),
    );
  }
}
