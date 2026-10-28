import 'package:root101/app_exporter.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class HomeScreenNavigator {
  String get name => RouteNames.home;

  String get path => '/';

  Widget builder(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

/// The sections the header jumps to
enum HomeSection { top, about, projects, team }

/// The landing: every section in one scroll, the header pinned on top
class HomeScreen extends StatefulWidget {
  static final HomeScreenNavigator navigator = HomeScreenNavigator();

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scroll = ScrollController();
  final Map<HomeSection, GlobalKey> _keys = {
    for (final section in HomeSection.values) section: GlobalKey(),
  };

  /// The anchors of the design (`#proyectos`) with `scroll-behavior: smooth`
  void _goTo(HomeSection section) {
    final context = _keys[section]!.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: this.context.reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // the header is pinned over the page, the page starts below it
                SizedBox(
                  key: _keys[HomeSection.top],
                  height: HomeHeader.height,
                ),
                RepaintBoundary(
                  child: HeroSection(
                    onSeeProjects: () => _goTo(HomeSection.projects),
                  ),
                ),
                const RepaintBoundary(child: MarqueeBand()),
                RepaintBoundary(
                  child: AboutSection(key: _keys[HomeSection.about]),
                ),
                RepaintBoundary(
                  child: ProjectsSection(key: _keys[HomeSection.projects]),
                ),
                RepaintBoundary(
                  child: TeamSection(key: _keys[HomeSection.team]),
                ),
                const RepaintBoundary(child: ContactSection()),
                const HomeFooter(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HomeHeader(onNavigate: _goTo),
          ),
        ],
      ),
    );
  }
}
