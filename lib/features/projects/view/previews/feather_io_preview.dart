import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Feather IO: the buckets screen of its console, in its own palette
class FeatherIoPreview extends StatelessWidget {
  static const Color _background = Color(0xFF13111C);
  static const Color _panel = Color(0xFF181622);
  static const Color _border = Color(0xFF575562);
  static const Color _control = Color(0xFF2F2C3F);
  static const Color _selected = Color(0xFF3D3065);
  static const Color _action = Color(0xFF5C4999);
  static const Color _grey2 = Color(0xFFE5E5E5);
  static const Color _grey3 = Color(0xFFAFAFAF);
  static const Color _grey1 = Color(0xFFF7F7F7);
  static const Color _white = Color(0xFFFFFFFF);

  static const String _bucket =
      '<ellipse cx="12" cy="6" rx="8" ry="2.5"/><path d="M4 6l1.8 12.6c.2 1.4 2.9 2.4 6.2 2.4s6-1 6.2-2.4L20 6"/>';

  static const List<_Bucket> _buckets = [
    _Bucket(
      'media-assets',
      Color(0xFF5C4999),
      '06/Sep/2026',
      'Images and video for the website',
      '1 284',
      '2.4 GB',
    ),
    _Bucket(
      'backups-db',
      Color(0xFF2652E0),
      '02/Sep/2026',
      'Nightly PostgreSQL dumps',
      '312',
      '18.7 GB',
    ),
    _Bucket(
      'user-uploads',
      Color(0xFF0F766E),
      '28/Aug/2026',
      'Files uploaded by users',
      '9 410',
      '6.1 GB',
    ),
  ];

  const FeatherIoPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _background,
      child: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'DMSans', color: _white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Rail(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 18,
                  children: [_header(), _stats(), _browser()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() => Row(
    spacing: 12,
    children: [
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buckets',
              style: TextStyle(
                fontSize: 22,
                height: 28 / 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Manage your S3 compatible buckets and storage resources.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, height: 16 / 12, color: _grey3),
            ),
          ],
        ),
      ),
      _button(
        label: 'Refresh',
        color: _control,
        fontSize: 12,
        icon: '<path d="M20 12a8 8 0 1 1-2.34-5.66L20 8.5"/><path d="M20 4v4.5h-4.5"/>',
      ),
      _button(
        label: 'Create Bucket',
        color: _action,
        fontSize: 13,
        bold: true,
        padding: 14,
        icon: '<path d="M12 5v14M5 12h14"/>',
      ),
    ],
  );

  Widget _button({
    required String label,
    required Color color,
    required double fontSize,
    required String icon,
    bool bold = false,
    double padding = 12,
  }) => Container(
    height: 34,
    padding: EdgeInsets.symmetric(horizontal: padding),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      spacing: 6,
      children: [
        StrokeIcon(icon, size: 13, color: _white, strokeWidth: 1.9),
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: bold ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    ),
  );

  Widget _stats() {
    Widget stat(String icon, String label, String value) => Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _panel,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _border),
        ),
        child: Row(
          spacing: 10,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0x33504575),
                borderRadius: BorderRadius.circular(9),
              ),
              child: StrokeIcon(
                icon,
                size: 18,
                color: _grey1,
                strokeWidth: 1.75,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: _grey1),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 22 / 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return Row(
      spacing: 10,
      children: [
        stat(_bucket, 'Total Buckets', '3'),
        stat(
          '<path d="M12 3l8 4.5v9L12 21l-8-4.5v-9z"/><path d="M4 7.5l8 4.5 8-4.5M12 12v9"/>',
          'Total Objects',
          '11 006',
        ),
        stat(
          '<ellipse cx="12" cy="5.5" rx="7" ry="2.5"/><path d="M5 5.5v13c0 1.4 3.1 2.5 7 2.5s7-1.1 7-2.5v-13"/><path d="M5 12c0 1.4 3.1 2.5 7 2.5s7-1.1 7-2.5"/>',
          'Total Storage',
          '27.2 GB',
        ),
      ],
    );
  }

  Widget _browser() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _panel,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          border: Border.all(color: _border),
        ),
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1B2C),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _grey3),
                ),
                child: const Row(
                  spacing: 8,
                  children: [
                    StrokeIcon(
                      '<circle cx="11" cy="11" r="6.5"/><path d="M20 20l-4.35-4.35"/>',
                      size: 16,
                      color: _grey3,
                      strokeWidth: 1.75,
                    ),
                    Text(
                      'Search buckets...',
                      style: TextStyle(fontSize: 12, color: _grey3),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 32,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: _control,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: _border),
              ),
              child: Row(
                spacing: 3,
                children: [
                  const SizedBox.square(
                    dimension: 24,
                    child: Center(
                      child: StrokeIcon(
                        '<path d="M9 6h11M9 12h11M9 18h11"/><circle cx="4.75" cy="6" r="1.25" fill="#afafaf" stroke="none"/><circle cx="4.75" cy="12" r="1.25" fill="#afafaf" stroke="none"/><circle cx="4.75" cy="18" r="1.25" fill="#afafaf" stroke="none"/>',
                        size: 14,
                        color: _grey3,
                        strokeWidth: 1.75,
                      ),
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _selected,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const StrokeIcon(
                      '<rect x="4" y="4" width="6.5" height="6.5" rx="1.5"/><rect x="13.5" y="4" width="6.5" height="6.5" rx="1.5"/><rect x="4" y="13.5" width="6.5" height="6.5" rx="1.5"/><rect x="13.5" y="13.5" width="6.5" height="6.5" rx="1.5"/>',
                      size: 14,
                      color: _white,
                      strokeWidth: 1.75,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: _border),
            right: BorderSide(color: _border),
            bottom: BorderSide(color: _border),
          ),
        ),
        child: Row(
          children: [
            for (final bucket in _buckets) Expanded(child: _card(bucket)),
          ],
        ),
      ),
    ],
  );

  Widget _card(_Bucket b) => Container(
    height: 200,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _panel,
      border: Border.all(color: _border, width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 8,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: b.color,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const StrokeIcon(
                _bucket,
                size: 18,
                color: _white,
                strokeWidth: 1.75,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 6,
                    children: [
                      Flexible(
                        child: Text(
                          b.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 18 / 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: _control,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          'R/W',
                          style: TextStyle(
                            fontSize: 10,
                            height: 14 / 10,
                            color: _grey2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Created ${b.created}',
                    style: const TextStyle(
                      fontSize: 9.5,
                      height: 13 / 9.5,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          b.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, height: 13 / 10, color: _grey3),
        ),
        Container(height: 1, color: _border),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _figure('Objects', b.objects, CrossAxisAlignment.start),
            _figure('Size', b.size, CrossAxisAlignment.end),
          ],
        ),
      ],
    ),
  );

  Widget _figure(String label, String value, CrossAxisAlignment align) =>
      Column(
        crossAxisAlignment: align,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: _grey2)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              height: 20 / 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
}

class _Bucket {
  final String name;
  final Color color;
  final String created;
  final String description;
  final String objects;
  final String size;

  const _Bucket(
    this.name,
    this.color,
    this.created,
    this.description,
    this.objects,
    this.size,
  );
}

/// The console's side rail: menu, sections, and the bottom actions
class _Rail extends StatelessWidget {
  const _Rail();

  @override
  Widget build(BuildContext context) {
    const grey2 = FeatherIoPreview._grey2;
    const grey3 = FeatherIoPreview._grey3;
    const border = FeatherIoPreview._border;
    Widget item(String icon, {required Color color, Color? fill}) => Container(
      width: 46,
      height: 28,
      margin: const EdgeInsets.only(top: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: StrokeIcon(icon, size: 20, color: color, strokeWidth: 1.75),
    );
    Widget boxed(Widget child, {double bottom = 0, double top = 0}) =>
        Container(
          width: 36,
          height: 36,
          margin: EdgeInsets.only(bottom: bottom, top: top),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: border),
          ),
          child: child,
        );
    return Container(
      width: 60,
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      decoration: const BoxDecoration(
        color: FeatherIoPreview._panel,
        border: Border(right: BorderSide(color: border)),
      ),
      child: Column(
        spacing: 4,
        children: [
          const SizedBox.square(
            dimension: 40,
            child: Center(
              child: StrokeIcon(
                '<path d="M4 6h16M4 12h16M4 18h16"/>',
                size: 20,
                color: grey2,
                strokeWidth: 1.75,
              ),
            ),
          ),
          4.gap(),
          item(
            '<path d="M3.5 7.5A1.5 1.5 0 0 1 5 6h4l2 2h8a1.5 1.5 0 0 1 1.5 1.5v8A1.5 1.5 0 0 1 19 19H5a1.5 1.5 0 0 1-1.5-1.5z"/>',
            color: FeatherIoPreview._white,
            fill: FeatherIoPreview._selected,
          ),
          item(FeatherIoPreview._bucket, color: grey3),
          item(
            '<circle cx="7.5" cy="15.5" r="4"/><path d="M10.5 12.5 20 3M17 6l3 3M14.5 8.5l2.5 2.5"/>',
            color: grey3,
          ),
          const Spacer(),
          boxed(
            const StrokeIcon(
              '<path d="M8 19V5M4 9l4-4 4 4"/><path d="M16 5v14M12 15l4 4 4-4"/>',
              size: 15,
              color: grey2,
              strokeWidth: 1.75,
            ),
            bottom: 6,
          ),
          boxed(
            const Text(
              'EN',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: grey2,
              ),
            ),
          ),
          boxed(
            const StrokeIcon(
              '<path d="M9 20H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h3"/><path d="M16 17l5-5-5-5M21 12H9"/>',
              size: 15,
              color: grey2,
              strokeWidth: 1.75,
            ),
            top: 6,
          ),
        ],
      ),
    );
  }
}
