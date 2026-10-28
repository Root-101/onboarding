import 'package:flutter_test/flutter_test.dart';
import 'package:root101/design_system/terminal/terminal_script.dart';

void main() {
  // the data of the design: typing ends at tick 93 ("~94" in the design) and a lap is 176 ticks
  final script = TerminalScript(
    command: 'root101 ls --projects',
    lines: const [
      TerminalLine(name: 'winter', description: 'backend framework for Dart'),
      TerminalLine(
        name: 'feather-io',
        description: 'S3-compatible object storage',
      ),
      TerminalLine(name: 'dumpling', description: 'database backups to S3'),
      TerminalLine(
        name: 'maple',
        description: 'personal finance · mobile + web',
      ),
    ],
  );

  group('TerminalScript', () {
    test('Keeps the timing of the design', () {
      expect(script.nameWidth, 12);
      expect(script.typingEnd, 93);
      expect(script.length, 176);
    });

    test('Types the command first, two characters a tick', () {
      final frame = script.frameAt(3);
      expect(frame.command, 'root10');
      expect(frame.typingCommand, isTrue);
      expect(frame.lines, isEmpty);
      expect(frame.done, isFalse);
    });

    test('Types a line name first, padded, then its description', () {
      // 46 characters: 21 + 10 of the command and its pause, 12 of the name, 3
      final frame = script.frameAt(23);
      expect(frame.typingCommand, isFalse);
      expect(frame.lines.single.name, 'winter      ');
      expect(frame.lines.single.description, 'bac');
    });

    test('Ends with every line and the prompt, then types clear', () {
      final done = script.frameAt(script.typingEnd + 1);
      expect(done.done, isTrue);
      expect(done.lines.map((l) => l.name.trim()), [
        'winter',
        'feather-io',
        'dumpling',
        'maple',
      ]);
      expect(done.lines.last.description, 'personal finance · mobile + web');
      expect(done.clear, '');

      expect(script.frameAt(script.length - 1).clear, 'clear');
    });

    test('A long name widens the name column', () {
      final wide = TerminalScript(
        command: 'ls',
        lines: const [TerminalLine(name: 'a-very-long-name', description: 'x')],
      );
      expect(wide.nameWidth, 18);
    });
  });
}
