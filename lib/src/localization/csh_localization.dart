import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/messages_all.dart';

class CshLocalizations {
  CshLocalizations(this.localeName);

  static Future<CshLocalizations> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty ?? false ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return CshLocalizations(localeName);
    });
  }

  static CshLocalizations? of(BuildContext context) {
    return Localizations.of<CshLocalizations>(context, CshLocalizations);
  }

  final String localeName;
}

class CshLocalizationsDelegate extends LocalizationsDelegate<CshLocalizations> {
  const CshLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    int index = LanguageUtil.getSupportedLanguageListLocale()
        .toList()
        .indexWhere((element) => element.languageCode == locale.languageCode);
    return index >= 0;
  }

  @override
  Future<CshLocalizations> load(Locale locale) => CshLocalizations.load(locale);

  @override
  bool shouldReload(CshLocalizationsDelegate old) => false;
}
