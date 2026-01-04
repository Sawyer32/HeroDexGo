import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/firebase_options.dart';
import 'package:hero_dex_go/repositories/auth_repository.dart';
import 'package:hero_dex_go/screens/auth/login_sreen.dart';
import 'package:hero_dex_go/screens/auth/register_screen.dart';
import 'package:hero_dex_go/screens/onboarding/onboarding.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
    fileName: "assets/.env"
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return Placeholder();
      }
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen();
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
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MaterialApp.router(
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
      ),
    );
  }
}
