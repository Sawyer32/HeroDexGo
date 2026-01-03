import 'package:flutter/material.dart';
import 'package:hero_dex_go/screens/onboarding/onboarding.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLightTheme = true;

  void toggleTheme() {
    setState(() => isLightTheme = !isLightTheme);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        extensions: const <ThemeExtension<dynamic>>[
          ThemeColors(primaryColor: Color(0xFF7F0DF2), backgroundColor: Color(0xFFF7F5F8))
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          const ThemeColors(primaryColor: Color(0xFF7F0DF2), backgroundColor: Color(0xFF191022))
        ]
      ),
      
      themeMode: isLightTheme ? ThemeMode.light: ThemeMode.dark,
      home: OnboardingScreen(),
    );
  }
}
