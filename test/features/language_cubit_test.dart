import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:root101/app_exporter.dart';

/// Storage that fails like the web one without WebCrypto (plain http)
class _BrokenRepo extends LanguageRepo {
  _BrokenRepo() : super(storage: const FlutterSecureStorage());

  @override
  Future<String?> loadKey() async => throw StateError('no storage');

  @override
  Future save({required LanguageModel model}) async =>
      throw StateError('no storage');
}

void main() {
  group('LanguageCubit', () {
    blocTest<LanguageCubit, LanguageState>(
      'Without storage it still lists the languages and can change',
      build: () => LanguageCubit(repo: _BrokenRepo()),
      act: (cubit) async {
        await Future<void>.delayed(Duration.zero);
        cubit.changeLanguageKey(languageKey: 'es');
      },
      expect: () => [
        isA<LanguageState>().having(
          (s) => s.allLanguages.length,
          'languages',
          2,
        ),
        isA<LanguageState>().having((s) => s.current.key, 'current', 'es'),
      ],
    );
  });
}
