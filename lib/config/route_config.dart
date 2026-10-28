import 'package:root101/app_exporter.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  RouteConfig._();

  static final GoRouter router = GoRouter(
    initialLocation: HomeScreen.navigator.path,
    navigatorKey: navigatorKey,
    // a single page: any other path (an old link, a typo) opens it
    redirect: (context, state) => state.uri.path == HomeScreen.navigator.path
        ? null
        : HomeScreen.navigator.path,
    routes: [
      GoRoute(
        name: HomeScreen.navigator.name,
        path: HomeScreen.navigator.path,
        builder: HomeScreen.navigator.builder,
      ),
    ],
  );
}
