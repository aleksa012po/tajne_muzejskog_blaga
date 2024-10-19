import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('sr'),
    const Locale('es'),
  ];

  /// Returns a user-friendly name for a given language code.
  static String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English - US';
      case 'sr':
        return 'Serbian - Latinica';
      case 'es':
        return 'Serbian - Ćirilica';
      default:
        return 'Unknown Language';
    }
  }

  /// Returns the corresponding Locale object for a given language name.
  static Locale getLocaleFromLanguage(String language) {
    switch (language) {
      case 'English - US':
        return const Locale('en');
      case 'Serbian - Latinica':
        return const Locale('sr');
      case 'Serbian - Ćirilica':
        return const Locale('es');
      default:
        return const Locale('en'); // Default to English if not recognized
    }
  }
}

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
