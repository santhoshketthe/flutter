import 'package:flutter/material.dart';
import 'package:flutter_project/form_page.dart';
import 'package:flutter_project/shared_perferences.dart';
import 'package:flutter_project/side_menu.dart';
import 'package:flutter_project/stack.dart';
import 'package:flutter_project/video_player.dart';
import 'package:flutter_project/widget_lifecycle.dart';
import 'app_localizations.dart';
import 'custom_layout.dart';
import 'future_builder.dart';
import 'layouts.dart';
import 'multi_language_support.dart';
import 'notepad.dart';

class Concepts extends StatefulWidget{
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  const Concepts({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  State<Concepts> createState() => _ConceptsState();
}

class _ConceptsState extends State<Concepts> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Concept")),
      body: Column(
        children: [
          TextButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const StackLayer())
            );
          }, child: const Text("Stack")),
          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormPage(isDarkMode: widget.isDarkMode, onThemeChanged: widget.onThemeChanged)));
          }, child: const Text("FormPage")),
          TextButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => WidgetLifeCycle())
            );
          }, child: const Text("WidgetLifeCycle")),
          TextButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CustomLayout())
            );
          }, child: const Text("Custom layout")),
          TextButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const VideoPlayerPage(videoUrl: 'assets/videos/ocean.mp4'))
            );
          }, child: const Text("video player")),
          TextButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Layouts())
            );
          }, child: const Text("Layouts")),
          TextButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FutureBuilderPage())
            );
          }, child: const Text("FutureBuilder")),
          TextButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SharedPreferencesPage())
            );
          }, child: const Text("Shared Preference")),
          TextButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotePad())
            );
          }, child: const Text("Sqlite")),
          TextButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SideMenuPage())
            );
          }, child: const Text("Side Menu")),
          // TextButton(onPressed: (){
          //   Navigator.of(context).push(
          //       MaterialPageRoute(builder: (context) => MultiLanguageSupportPage(onChangeLanguage: _changeLanguage),)
          //   );
          // }, child: const Text("multi language support")),
        ],
      ),
    );
  }
}