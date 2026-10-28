import 'dart:ui' show PlatformDispatcher;

import 'package:root101/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final LanguageRepo repo;

  static final LanguageModel defaultLanguage = LanguageModel(
    icon: app.assets.icons.language.en,
    key: 'en',
    name: 'English',
  );

  static final List<LanguageModel> languages = [
    defaultLanguage,
    LanguageModel(
      icon: app.assets.icons.language.es,
      key: 'es',
      name: 'Español',
    ),
  ];

  LanguageCubit({required this.repo})
    : super(LanguageState(current: defaultLanguage, allLanguages: languages)) {
    init();
  }

  /// The one picked before; a first visit gets the browser's language, or
  /// [defaultLanguage] (English) when the site doesn't have it
  Future init() async {
    String? key;
    try {
      key = await repo.loadKey();
    } catch (_) {
      // no storage (WebCrypto needs https, or site data is blocked): the
      // browser's language, and the picker still works
    }
    emit(
      LanguageState(
        current: _resolve(
          key: key ?? PlatformDispatcher.instance.locale.languageCode,
        ),
        allLanguages: languages,
      ),
    );
  }

  void changeLanguageKey({required String languageKey}) {
    LanguageModel? language = languages
        .where((element) => element.key == languageKey)
        .firstOrNull;
    changeLanguage(language: language);
  }

  void changeLanguage({LanguageModel? language}) {
    if (language == null) {
      return;
    }
    // not remembered when there is no storage, see [init]
    repo.save(model: language).ignore();
    emit(LanguageState(current: language, allLanguages: languages));
  }

  LanguageModel _resolve({required String? key}) {
    if (key == null) {
      return defaultLanguage;
    }
    return languages.firstWhere(
      (element) => element.key == key,
      orElse: () => defaultLanguage,
    );
  }
}

// states
class LanguageState {
  final LanguageModel current;
  final List<LanguageModel> allLanguages;

  const LanguageState({required this.current, required this.allLanguages});
}
