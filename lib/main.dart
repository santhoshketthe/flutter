import 'package:flutter/material.dart';
import 'package:flutter_project/form_page.dart';
import 'package:flutter_project/layouts.dart';
import 'package:flutter_project/set_state.dart';
import 'package:flutter_project/stack.dart';
import 'package:flutter_project/video_player.dart';
import 'package:flutter_project/widget_lifecycle.dart';
import 'custom_layout.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),  // Light theme
      darkTheme: ThemeData.dark(),  // Dark theme
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
     // theme: ThemeData.dark(useMaterial3: true),
      //  home: const Layouts()
       home: const VideoPlayerPage(videoUrl: 'assets/videos/ocean.mp4'),
     // home: const CustomLayout()
     // home: WidgetLifeCycle()
      // home:StackLayer(),
      //home: FormPage(key: UniqueKey(),isDarkMode: isDarkMode,onThemeChanged: toggleTheme),

    );
  }
}
