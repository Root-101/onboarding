import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Maple: two phones (the accounts and an account's operations) and a card of
/// upcoming payments, in Maple's own palette
class MaplePreview extends StatelessWidget {
  static const Color cream = Color(0xFFF7F4EE);
  static const Color ink = Color(0xFF17201D);
  static const Color deep = Color(0xFF0B3D35);
  static const Color green = Color(0xFF0E6B5C);
  static const Color mint = Color(0xFFE3F0EC);
  static const Color red = Color(0xFFB8432A);
  static const Color grey = Color(0xFF5E6863);
  static const Color greyDark = Color(0xFF3F4945);
  static const Color hint = Color(0xFF7C8580);
  static const Color line = Color(0xFFE8E3D9);
  static const Color divider = Color(0xFFF0ECE4);
  static const Color field = Color(0xFFD9D3C7);
  static const Color white = Color(0xFFFFFFFF);

  /// The dark backdrop behind the phones, with its two circles
  static const Color backdrop = Color(0xFF0A1715);
  static const Color backdropGreen = Color(0xFF10322C);
  static const Color backdropClay = Color(0xFF2E1A15);

  static const String archive = 'M3 5h18v4H3zM5 9v10h14V9M10 13h4';
  static const String edit = 'M4 20h4L19 9l-4-4L4 16zM13.5 6.5l4 4';
  static const String pin = 'M9 3h6l-1 6 4 4H6l4-4zM12 13v8';

  /// Only the accounts phone (the preview on a phone screen)
  final bool compact;

  const MaplePreview({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backdrop,
      child: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'PlusJakartaSans', color: ink),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -80,
              top: -90,
              child: _circle(300, backdropGreen),
            ),
            Positioned(
              left: -60,
              bottom: -100,
              child: _circle(240, backdropClay),
            ),
            if (compact)
              const Center(child: _Phone(child: _AccountsScreen()))
            else
              // room on the right for the card that sticks out of the second phone
              const Padding(
                padding: EdgeInsets.only(right: 202),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 64,
                    children: [
                      _Phone(child: _AccountsScreen()),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _Phone(child: _AccountScreen()),
                          Positioned(
                            right: -206,
                            top: 22,
                            child: _UpcomingCard(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Widget _circle(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  static Widget icon(
    String d, {
    double size = 20,
    Color color = deep,
    double stroke = 2,
    bool filled = false,
  }) => StrokeIcon(
    '<path d="$d"/>',
    size: size,
    color: color,
    strokeWidth: stroke,
    filled: filled,
  );

  /// A 44 px square with an icon
  static Widget iconBox(String d, {double size = 20, Color color = deep}) =>
      SizedBox.square(
        dimension: 44,
        child: Center(
          child: icon(d, size: size, color: color),
        ),
      );

  /// The pill fields of Maple, cut in two (search | action)
  static Widget searchRow({
    required String hint,
    required Widget leading,
    required Widget trailing,
    double trailingWidth = 0,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 14),
  }) {
    BoxDecoration half(BorderRadius radius) => BoxDecoration(
      color: white,
      borderRadius: radius,
      border: Border.all(color: field, width: 1.5),
    );
    return SizedBox(
      height: 46,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4,
        children: [
          Expanded(
            child: Container(
              padding: padding,
              decoration: half(
                const BorderRadius.horizontal(
                  left: Radius.circular(23),
                  right: Radius.circular(6),
                ),
              ),
              child: Row(
                spacing: 8,
                children: [
                  leading,
                  Text(
                    hint,
                    style: const TextStyle(
                      fontSize: 15,
                      color: MaplePreview.hint,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: trailingWidth == 0 ? null : trailingWidth,
            padding: trailingWidth == 0
                ? const EdgeInsets.fromLTRB(12, 0, 14, 0)
                : EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: half(
              const BorderRadius.horizontal(
                left: Radius.circular(6),
                right: Radius.circular(23),
              ),
            ),
            child: trailing,
          ),
        ],
      ),
    );
  }
}

/// A phone: a 390x844 screen at 60 % inside a 6 px frame
class _Phone extends StatelessWidget {
  final Widget child;

  const _Phone({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 246,
      height: 518,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: MaplePreview.ink, width: 6),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 30),
            blurRadius: 60,
            color: Color(0x400B3D35),
          ),
        ],
      ),
      // the screen keeps the inner radius (32 - 6), or its corners eat the frame
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: FittedBox(
          fit: BoxFit.fill,
          child: SizedBox(
            width: 390,
            height: 844,
            child: ColoredBox(color: MaplePreview.cream, child: child),
          ),
        ),
      ),
    );
  }
}

class _Account {
  final String name;
  final String currency;
  final String balance;
  final bool pinned;

  const _Account(this.name, this.currency, this.balance, {this.pinned = false});
}

/// "My accounts": the accounts by section, a FAB and the bottom navigation
class _AccountsScreen extends StatelessWidget {
  const _AccountsScreen();

  static const List<(String, bool, List<_Account>)> _sections = [
    (
      'Pinned',
      true,
      [
        _Account('NuBank', 'MXN', r'$4 170.21', pinned: true),
        _Account('Mercado Pago Wallet', 'MXN', r'$6 953.99', pinned: true),
      ],
    ),
    ('Daily', false, [_Account('Wallet', 'MXN', r'$926.00')]),
    (
      'Savings',
      false,
      [
        _Account('Emergency fund', 'MXN', r'$6 760.00'),
        _Account('Secret stash', 'USD', r'$1 200.00'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.topCenter,
                  maxHeight: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 52, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 18,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'My accounts',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: AppText.em(-0.02, 26),
                                  color: MaplePreview.deep,
                                ),
                              ),
                            ),
                            MaplePreview.iconBox(MaplePreview.archive),
                            4.gap(),
                            MaplePreview.iconBox(
                              'M8 6h12M8 12h12M8 18h12M4 6h.01M4 12h.01M4 18h.01',
                            ),
                          ],
                        ),
                        MaplePreview.searchRow(
                          hint: 'Search account',
                          leading: MaplePreview.icon(
                            'M11 4a7 7 0 1 0 0 14a7 7 0 1 0 0-14M20 20l-3.5-3.5',
                            size: 18,
                            color: MaplePreview.grey,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4,
                            children: [
                              MaplePreview.icon(
                                'M12 2v20M17 6H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6',
                                size: 18,
                                color: MaplePreview.greyDark,
                              ),
                              MaplePreview.icon(
                                'M6 9l6 6 6-6',
                                size: 14,
                                color: MaplePreview.greyDark,
                                stroke: 2.4,
                              ),
                            ],
                          ),
                        ),
                        for (final (title, pinned, items) in _sections)
                          _section(title, pinned, items),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const _BottomNav(),
          ],
        ),
        Positioned(
          right: 20,
          bottom: 96,
          child: Container(
            width: 58,
            height: 58,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MaplePreview.green,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 20,
                  color: Color(0x520E6B5C),
                ),
              ],
            ),
            child: MaplePreview.icon(
              'M12 5v14M5 12h14',
              size: 24,
              color: MaplePreview.white,
              stroke: 2.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _section(String title, bool pinned, List<_Account> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        SizedBox(
          height: 24,
          child: Row(
            spacing: 6,
            children: [
              if (pinned)
                MaplePreview.icon(
                  'M9 4h6l-1 6 3 3H7l3-3zM12 13v7',
                  size: 14,
                  color: MaplePreview.red,
                  filled: true,
                ),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: AppText.em(0.06, 12),
                  color: MaplePreview.grey,
                ),
              ),
              const Spacer(),
              MaplePreview.icon(
                'M6 9l6 6 6-6',
                size: 16,
                color: MaplePreview.grey,
                stroke: 2.4,
              ),
            ],
          ),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: MaplePreview.divider,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: MaplePreview.line),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 1,
              children: [
                for (var i = 0; i < 2; i++)
                  Expanded(
                    child: i < items.length
                        ? _AccountTile(account: items[i])
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AccountTile extends StatelessWidget {
  final _Account account;

  const _AccountTile({required this.account});

  @override
  Widget build(BuildContext context) {
    final pinColor = account.pinned ? MaplePreview.red : MaplePreview.green;
    Widget action(
      String d, {
      Color color = MaplePreview.green,
      bool filled = false,
    }) => SizedBox(
      width: 44,
      height: 40,
      child: Center(
        child: MaplePreview.icon(d, size: 18, color: color, filled: filled),
      ),
    );
    return Container(
      color: MaplePreview.white,
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 4),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -4,
            right: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: MaplePreview.divider,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                account.currency,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: AppText.em(0.05, 10),
                  color: MaplePreview.greyDark,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 4,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 14, 4, 0),
                child: Text(
                  account.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                account.balance,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: AppText.em(-0.02, 20),
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: MaplePreview.deep,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  action(MaplePreview.edit),
                  action(MaplePreview.archive),
                  action(
                    MaplePreview.pin,
                    color: pinColor,
                    filled: account.pinned,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    Widget item(String d, String label, {bool active = false}) {
      final color = active ? MaplePreview.green : MaplePreview.grey;
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Container(
              width: active ? 56 : null,
              height: 30,
              alignment: Alignment.center,
              decoration: active
                  ? BoxDecoration(
                      color: MaplePreview.mint,
                      borderRadius: BorderRadius.circular(15),
                    )
                  : null,
              child: MaplePreview.icon(d, color: color),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: MaplePreview.white,
        border: Border(top: BorderSide(color: MaplePreview.line)),
      ),
      child: Row(
        children: [
          item(
            'M3 11l9-7 9 7v9a1 1 0 0 1-1 1h-5v-6h-6v6H4a1 1 0 0 1-1-1z',
            'Home',
          ),
          item(
            'M3 7a2 2 0 0 1 2-2h13v3M3 7v11a2 2 0 0 0 2 2h14a1 1 0 0 0 1-1v-9a1 1 0 0 0-1-1H5a2 2 0 0 1-2-2zM16 14h.01',
            'Accounts',
            active: true,
          ),
          item('M4 20V10M10 20V4M16 20v-7M22 20H2', 'Summary'),
          item(
            'M12 4a4 4 0 1 0 0 8a4 4 0 1 0 0-8M4 21a8 8 0 0 1 16 0',
            'Profile',
          ),
        ],
      ),
    );
  }
}

/// "Account details": the account card and its operations by day
class _AccountScreen extends StatelessWidget {
  const _AccountScreen();

  static const Map<String, String> _icons = {
    'food': 'M7 3v8M5 3v5a2 2 0 0 0 4 0V3M7 11v10M17 3c-2 0-3 2-3 5s1 4 3 4v9',
    'cart': 'M3 4h2l2.4 11h10.2L20 8H6.2M9 20h.01M17 20h.01',
    'coffee': 'M4 8h13v5a5 5 0 0 1-5 5H9a5 5 0 0 1-5-5zM17 9h1a3 3 0 0 1 0 6h-1M8 3v2M12 3v2',
    'transfer': 'M4 8h15l-3-3M20 16H5l3 3',
  };

  // (name, category, amount, icon, income)
  static const List<(String, List<(String, String, String, String, bool)>)>
  _days = [
    (
      'Today · Oct 10',
      [
        ('Sushi', 'Food · Restaurants', r'− $489.35', 'food', false),
        (
          'Specialty coffee',
          'Food · Coffee shop',
          r'− $88.00',
          'coffee',
          false,
        ),
      ],
    ),
    (
      'Yesterday · Oct 9',
      [
        (
          'Transfer from NuBank',
          'Income · Transfer',
          r'+ $808.00',
          'transfer',
          true,
        ),
        ('Weekly groceries', 'Groceries', r'− $1 768.97', 'cart', false),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
          child: OverflowBox(
            alignment: Alignment.topCenter,
            maxHeight: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 44, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  Transform.translate(
                    offset: const Offset(-8, 0),
                    child: Row(
                      spacing: 4,
                      children: [
                        MaplePreview.iconBox(
                          'M19 12H5M11 6l-6 6 6 6',
                          size: 22,
                        ),
                        const Expanded(
                          child: Text(
                            'Account details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: MaplePreview.deep,
                            ),
                          ),
                        ),
                        MaplePreview.iconBox(MaplePreview.edit),
                        MaplePreview.iconBox(MaplePreview.archive),
                        MaplePreview.iconBox(MaplePreview.pin),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: _AccountCard(),
                  ),
                  MaplePreview.searchRow(
                    hint: 'Search this account',
                    padding: const EdgeInsets.fromLTRB(16, 0, 14, 0),
                    leading: MaplePreview.icon(
                      'M11 4a7 7 0 1 0 0 14a7 7 0 1 0 0-14M20 20l-3.5-3.5',
                      size: 18,
                      color: MaplePreview.grey,
                    ),
                    trailingWidth: 52,
                    trailing: MaplePreview.icon(
                      'M4 5h16l-6 7.5V19l-4 1v-7.5z',
                      size: 18,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 14,
                    children: [
                      for (final (date, ops) in _days)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 8,
                          children: [
                            Text(
                              date.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: AppText.em(0.06, 12),
                                color: MaplePreview.grey,
                              ),
                            ),
                            for (final op in ops) _operation(op),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 28,
          child: Container(
            height: 56,
            padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
            decoration: BoxDecoration(
              color: MaplePreview.green,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 20,
                  color: Color(0x520E6B5C),
                ),
              ],
            ),
            child: Row(
              spacing: 8,
              children: [
                MaplePreview.icon(
                  'M12 5v14M5 12h14',
                  size: 22,
                  color: MaplePreview.white,
                  stroke: 2.4,
                ),
                const Text(
                  'Operation',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: MaplePreview.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _operation((String, String, String, String, bool) op) {
    final (name, category, amount, icon, income) = op;
    return Container(
      decoration: BoxDecoration(
        color: MaplePreview.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MaplePreview.line),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 62),
              padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
              child: Row(
                spacing: 12,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MaplePreview.mint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MaplePreview.icon(_icons[icon]!, stroke: 1.9),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: MaplePreview.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: income ? MaplePreview.green : MaplePreview.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 40,
            height: 44,
            margin: const EdgeInsets.only(right: 4),
            alignment: Alignment.center,
            child: MaplePreview.icon(
              'M12 5h.01M12 12h.01M12 19h.01',
              color: MaplePreview.greyDark,
              stroke: 3,
            ),
          ),
        ],
      ),
    );
  }
}

/// The account card: notched on both sides like a ticket, with its rings
class _AccountCard extends StatelessWidget {
  const _AccountCard();

  @override
  Widget build(BuildContext context) {
    const soft = Color(0xFFCDE7E0);
    const ball = BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        center: Alignment(0, -0.24),
        colors: [Color(0xFFE4F7F1), Color(0xFFE4F7F1), Color(0xFFBFE6DB)],
        stops: [0, 0.45, 1],
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 2,
          color: Color(0x470B3D35),
        ),
      ],
    );
    return SizedBox(
      width: 350,
      height: 158,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned.fill(child: CustomPaint(painter: _TicketPainter())),
          // the beads on top
          Positioned(
            left: 0,
            right: 0,
            top: -13,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 7,
              children: [
                for (final size in const [
                  14.0,
                  18.0,
                  14.0,
                  14.0,
                  14.0,
                  14.0,
                  14.0,
                ])
                  Container(width: size, height: size, decoration: ball),
              ],
            ),
          ),
          Positioned(
            left: -10,
            top: 69,
            child: MaplePreview.icon('M15 5l-7 7 7 7', stroke: 3.6),
          ),
          Positioned(
            right: -10,
            top: 69,
            child: MaplePreview.icon('M9 5l7 7-7 7', stroke: 3.6),
          ),
          Positioned(
            right: 14,
            top: 30,
            child: MaplePreview.icon(
              'M9 4h6l-1 6 3 3H7l3-3zM12 13v7',
              size: 18,
              color: MaplePreview.white,
              filled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(36, 20, 36, 14),
            child: DefaultTextStyle.merge(
              style: const TextStyle(color: MaplePreview.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Text(
                        'Mercado Pago Wallet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Card and QR payments',
                        style: TextStyle(fontSize: 13, color: soft),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      const Text(
                        'Balance',
                        style: TextStyle(fontSize: 13, color: soft),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 10,
                        children: [
                          Text(
                            r'$6 953.99',
                            style: TextStyle(
                              fontSize: 34,
                              height: 1.1,
                              fontWeight: FontWeight.w800,
                              letterSpacing: AppText.em(-0.02, 34),
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2A8273),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'MXN',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.2,
                                fontWeight: FontWeight.w700,
                                letterSpacing: AppText.em(0.06, 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The card's shape of the design (350x158, a notch on each side) in green,
/// with its rings in the bottom right corner and a soft shadow
class _TicketPainter extends CustomPainter {
  const _TicketPainter();

  static Path _shape() => Path()
    ..moveTo(10, 0)
    ..lineTo(340, 0)
    ..quadraticBezierTo(350, 0, 350, 10)
    ..lineTo(350, 55)
    ..cubicTo(350, 61, 347.5, 64, 344.5, 67)
    ..lineTo(336, 75.5)
    ..quadraticBezierTo(333.5, 78, 333.5, 79)
    ..quadraticBezierTo(333.5, 80, 336, 82.5)
    ..lineTo(344.5, 91)
    ..cubicTo(347.5, 94, 350, 97, 350, 103)
    ..lineTo(350, 148)
    ..quadraticBezierTo(350, 158, 340, 158)
    ..lineTo(10, 158)
    ..quadraticBezierTo(0, 158, 0, 148)
    ..lineTo(0, 103)
    ..cubicTo(0, 97, 2.5, 94, 5.5, 91)
    ..lineTo(14, 82.5)
    ..quadraticBezierTo(16.5, 80, 16.5, 79)
    ..quadraticBezierTo(16.5, 78, 14, 75.5)
    ..lineTo(5.5, 67)
    ..cubicTo(2.5, 64, 0, 61, 0, 55)
    ..lineTo(0, 10)
    ..quadraticBezierTo(0, 0, 10, 0)
    ..close();

  @override
  void paint(Canvas canvas, Size size) {
    final shape = _shape();
    canvas.drawPath(
      shape.shift(const Offset(0, 4)),
      Paint()
        ..color = const Color(0x380B3D35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    canvas.drawPath(shape, Paint()..color = MaplePreview.green);
    canvas.save();
    canvas.clipPath(shape);
    final ring = Paint()
      ..color = const Color(0x1CFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    const center = Offset(326, 158);
    canvas.drawCircle(center, 90, ring);
    canvas.drawCircle(center, 56, ring);
    canvas.drawCircle(center, 24, Paint()..color = const Color(0x17FFFFFF));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _TicketPainter oldDelegate) => false;
}

/// "Upcoming payments", floating out of the second phone
class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard();

  static const List<(String, String, String, String)> _payments = [
    (
      'Internet',
      'Nov 5 · in 3 days',
      r'$442.00',
      'M2 9a15 15 0 0 1 20 0M5 12.5a10 10 0 0 1 14 0M8.5 16a5 5 0 0 1 7 0M12 19.5h.01',
    ),
    (
      'Spotify',
      'Nov 8 · in 6 days',
      r'$93.00',
      'M9 18V5l12-2v13M9 18a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM21 16a3 3 0 1 1-6 0 3 3 0 0 1 6 0z',
    ),
    (
      'Rent',
      'Nov 15 · in 13 days',
      r'$5 520.00',
      'M4 11l8-7 8 7v9H4zM10 20v-5h4v5',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MaplePreview.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MaplePreview.line),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 24),
            blurRadius: 50,
            color: Color(0x380B3D35),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming payments',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: MaplePreview.deep,
                ),
              ),
              MaplePreview.icon(
                'M4 6h16v14H4zM4 10h16M8 3v4M16 3v4',
                size: 16,
                color: MaplePreview.green,
              ),
            ],
          ),
          for (var i = 0; i < _payments.length; i++) ...[
            if (i > 0) Container(height: 1, color: MaplePreview.divider),
            _payment(_payments[i]),
          ],
        ],
      ),
    );
  }

  Widget _payment((String, String, String, String) p) {
    final (name, due, amount, icon) = p;
    return Row(
      spacing: 10,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MaplePreview.mint,
            borderRadius: BorderRadius.circular(9),
          ),
          child: MaplePreview.icon(icon, size: 16, stroke: 1.9),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                due,
                style: const TextStyle(fontSize: 10, color: MaplePreview.grey),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFeatures: [FontFeature.tabularFigures()],
            color: MaplePreview.red,
          ),
        ),
      ],
    );
  }
}
