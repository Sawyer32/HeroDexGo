import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/firebase_options.dart';
import 'package:hero_dex_go/repositories/auth_repository.dart';
import 'package:hero_dex_go/repositories/search_repository.dart';
import 'package:hero_dex_go/screens/auth/login_sreen.dart';
import 'package:hero_dex_go/screens/auth/register_screen.dart';
import 'package:hero_dex_go/screens/search/search_screen.dart';
import 'package:hero_dex_go/screens/main_wrapper.dart';
import 'package:hero_dex_go/screens/onboarding/onboarding.dart';
import 'package:hero_dex_go/services/api_client.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
    fileName: "assets/.env"
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>(create: (context) => ApiClient()),
        RepositoryProvider<AuthRepository>(create:(context) => AuthRepository()),
        RepositoryProvider<SearchRepository>(create:(context) => SearchRepository(apiClient: context.read<ApiClient>()),),
      ],
      child: const MyApp(),
    ),
  );
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  initialLocation: '/',
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
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen();
      }
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainWrapper(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collection',
              builder: (context, state) => const Placeholder() // TODO: Build collection page
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen()
            ),
          ],
        ),
        
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const Placeholder() // TODO: Build profile page
            ),
          ],
        ),
      ]
    )
  ]
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLightTheme = false;

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
            ThemeColors(
              primaryColor: Color(0xFF7F0DF2), 
              primaryTextColor: Color(0xFF000000), 
              backgroundColor: Color(0xFFF7F5F8), 
              cardBackgroundColor: Color(0xFFFFFFFF)
            ),
          ],
        ),
        darkTheme: ThemeData.dark().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            const ThemeColors(
              primaryColor: Color(0xFF7F0DF2), 
              primaryTextColor: Color(0xFFFFFFFF), 
              backgroundColor: Color(0xFF191022), 
              cardBackgroundColor: Color(0xFF2D2335)
            ),
          ]
        ),
        
        themeMode: isLightTheme ? ThemeMode.light: ThemeMode.dark,
      );
  }
}
