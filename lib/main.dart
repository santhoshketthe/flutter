import 'package:flutter/material.dart';
import 'package:flutter_project/multi_language_support.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

void main() async {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  void toggleTheme(bool isDark) {
    setState(() {
      isDarkMode = isDark;
    });
  }
  Locale _locale = const Locale('en', '');

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  void _loadLocale() async {
    await AppLocalizations.load(_locale);
    setState(() {});
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode, '');
      AppLocalizations.load(_locale);
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],

      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),  // Light theme
      darkTheme: ThemeData.dark(),  // Dark theme
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
     // home :  Concepts(isDarkMode : isDarkMode,onThemeChanged : toggleTheme),
      home: MultiLanguageSupportPage(onChangeLanguage: _changeLanguage),
    );
  }
}
