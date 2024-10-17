import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';

class AppLocalizations {
  static Map<String, String> _localizedStrings = {};

  static Future<void> load(Locale locale) async {
    String jsonString = await rootBundle.loadString('l10n/${locale.languageCode}.json');

    _localizedStrings = Map<String, String>.from(json.decode(jsonString));
  }

  static String? translate(String key) {
    return _localizedStrings[key];
  }
}
