import 'package:root101/l10n/messages.g.dart';
import 'package:flutter/widgets.dart';

/// One instance per language, built once
final Map<AppMessagesLocale, AppMessages> _cache = {
  for (final locale in AppMessagesLocale.values) locale: locale.buildSync(),
};

/// The languages of the site, for `MaterialApp.supportedLocales`
final List<Locale> appSupportedLocales = [
  for (final locale in AppMessagesLocale.values) Locale(locale.languageCode),
];

/// The language of [locale]: a region uses its language (`es-MX` → `es`) and
/// an unknown language the base one (`en`)
AppMessagesLocale appLocaleOf(Locale locale) => AppLocaleUtils.parseLocaleParts(
  languageCode: locale.languageCode,
  countryCode: locale.countryCode,
);

/// Texts of [locale]
AppMessages messagesOf(Locale locale) => _cache[appLocaleOf(locale)]!;

extension AppLocalizationsX on BuildContext {
  /// Texts of the language of the enclosing `MaterialApp` (rebuilds when it
  /// changes)
  AppMessages get intl => messagesOf(Localizations.localeOf(this));
}
