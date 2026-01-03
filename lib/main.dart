import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/screens/login/login_sreen.dart';
import 'package:hero_dex_go/screens/onboarding/onboarding.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return OnboardingScreen();
      }
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      }
    )
  ]
);

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
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      routerConfig: _router,
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
    );
  }
}
