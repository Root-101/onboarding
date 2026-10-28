import 'package:root101/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// The Material texts that `material_ui` widgets read; the site's own come
/// from `context.intl` (slang). Every MaterialApp uses these (app and splash)
const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates = [
  ...GlobalMaterialLocalizations.delegates,
];

/// Narrower than this, the page takes its phone layout (`context.isCompact`)
const double minDesktopWidth = 1024;

// generate code
// fvm dart run slang

// fvm flutter analyze
// fvm flutter test
// fvm flutter run -d chrome --web-port=8080
// fvm flutter build web --no-web-resources-cdn   (docker/ serves build/web)
class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    await FeaturesInit.init();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiBlocProvider(
            providers: [...FeaturesInit.blocProviders],
            child: const App(),
          );
        } else {
          return const SplashScreen();
        }
      },
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LanguageListener(
      onLanguageChangeBuilder: (locale) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => context.intl.app.title,
        theme: ThemeConfig.theme,
        locale: locale,
        routerConfig: RouteConfig.router,
        localizationsDelegates: appLocalizationsDelegates,
        supportedLocales: appSupportedLocales,
      ),
    );
  }
}

AppGlobal app = AppGlobal();

class AppGlobal {
  static final AppGlobal _instance = AppGlobal._internal();

  AppGlobal._internal();

  factory AppGlobal() => _instance;

  /// Texts of the site's language; without a navigator yet (or in tests),
  /// English
  AppMessages get intl {
    final context = navigatorKey.currentContext;
    if (context != null) return context.intl;
    return messagesOf(const Locale('en'));
  }

  DI di = DI();

  AppDimensions dimensions = AppDimensions();

  AppColors colors = AppColors();

  AppAssets assets = AppAssets();
}
