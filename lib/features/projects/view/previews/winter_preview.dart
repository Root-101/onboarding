import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Winter: a route and its `main`, highlighted like Winter's own docs
class WinterPreview extends StatelessWidget {
  static const Color _background = Color(0xFF0B1620);
  static const Color _text = Color(0xFFDBE5EB);
  static const Color _keyword = Color(0xFF6CC2E0);
  static const Color _string = Color(0xFFF2B544);
  static const Color _type = Color(0xFFBFDDE9);

  const WinterPreview({super.key});

  // each line: (text, color) pieces; null is the plain text color
  static const List<List<(String, Color?)>> _code = [
    [
      ('import', _keyword),
      (' ', null),
      ("'package:winter/winter.dart'", _string),
      (';', null),
    ],
    [],
    [
      ('WinterRouter', _type),
      (' router() => ', null),
      ('WinterRouter', _type),
      ('(', null),
    ],
    [('  routes: [', null)],
    [('    ', null), ('Route', _type), ('.get(', null)],
    [('      path: ', null), ("'/users/{id}'", _string), (',', null)],
    [
      ('      handler: (request) => ', null),
      ('ResponseEntity', _type),
      ('.ok(', null),
    ],
    [
      ('        body: di.find<', null),
      ('UserService', _type),
      ('>().detailsById(', null),
    ],
    [
      ('          request.pathParam<', null),
      ('int', _type),
      ('>(', null),
      ("'id'", _string),
      ('),', null),
    ],
    [('        ),', null)],
    [('      ),', null)],
    [('    ),', null)],
    [('  ],', null)],
    [(');', null)],
    [],
    [
      ('Future', _type),
      ('<', null),
      ('void', _keyword),
      ('> main() ', null),
      ('async', _keyword),
      (' {', null),
    ],
    [('  di.put(', null), ('UserService', _type), ('());', null)],
    [
      ('  ', null),
      ('await', _keyword),
      (' ', null),
      ('Winter', _type),
      ('.start(router: router());', null),
    ],
    [('}', null)],
  ];

  @override
  Widget build(BuildContext context) {
    final style = AppText.mono.copyWith(
      fontSize: 14,
      height: 1.55,
      color: _text,
    );
    return ColoredBox(
      color: _background,
      child: CustomPaint(
        painter: const DotGridPainter(
          color: Color(0x12BFDDE9),
          spacing: 24,
          radius: 1.3,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in _code)
                Text.rich(
                  TextSpan(
                    children: [
                      for (final (text, color) in line)
                        TextSpan(
                          text: text,
                          style: TextStyle(color: color),
                        ),
                    ],
                  ),
                  style: style,
                  softWrap: false,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
