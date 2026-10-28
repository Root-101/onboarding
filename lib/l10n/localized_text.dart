import 'package:root101/l10n/l10n.dart';
import 'package:root101/l10n/messages.g.dart';
import 'package:flutter/widgets.dart';

/// A text of the hand-written catalogs (projects, team...) in every language
/// of the site. The UI copy lives in `*.i18n.yaml`; the catalogs keep each
/// entry in one place, so adding a project is adding one object.
///
/// A new language in slang breaks the `switch` below until it gets its field
class LocalizedText {
  final String en;
  final String es;

  const LocalizedText({required this.en, required this.es});

  /// The same text in every language (names, tech words)
  const LocalizedText.same(String text) : en = text, es = text;

  String resolve(Locale locale) => switch (appLocaleOf(locale)) {
    AppMessagesLocale.en => en,
    AppMessagesLocale.es => es,
  };

  /// In the language of the enclosing `MaterialApp`
  String of(BuildContext context) => resolve(Localizations.localeOf(context));
}
