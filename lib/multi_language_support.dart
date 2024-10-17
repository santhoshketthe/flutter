import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_localizations.dart';

class MultiLanguageSupportPage extends StatefulWidget {
  const MultiLanguageSupportPage({super.key, required this.onChangeLanguage});
  final Function(String) onChangeLanguage;
  @override
  State<StatefulWidget> createState() => MultiLanguageSupport();
}

class MultiLanguageSupport extends State<MultiLanguageSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate('title') ?? ''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.translate('greeting') ?? ''),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => widget.onChangeLanguage('en'),
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () => widget.onChangeLanguage('es'),
              child: Text('Español'),
            ),
          ],
        ),
      ),
    );
  }
}
