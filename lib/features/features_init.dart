import 'package:root101/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FeaturesInit {
  static Future<void> init() async {
    FlutterSecureStorage storage = const FlutterSecureStorage(
      webOptions: WebOptions(publicKey: 'root101'),
    );
    app.di.put(storage);

    await LanguageInit.init();
    await ProjectsInit.init();
  }

  static List<BlocProvider> blocProviders = [
    // LANGUAGE
    BlocProvider<LanguageCubit>(
      create: (context) => app.di.find<LanguageCubit>(),
    ),
    // PROJECTS: the open project of the projects section
    BlocProvider<ProjectCubit>(
      create: (context) => app.di.find<ProjectCubit>(),
    ),
  ];
}
