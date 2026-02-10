import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/bloc/settings/settings_bloc.dart';
import 'package:hero_dex_go/bloc/settings/settings_event.dart';
import 'package:hero_dex_go/bloc/settings/settings_state.dart';
import 'package:hero_dex_go/firebase_options.dart';
import 'package:hero_dex_go/repositories/auth_repository.dart';
import 'package:hero_dex_go/repositories/onboarding_repository.dart';
import 'package:hero_dex_go/repositories/search_repository.dart';
import 'package:hero_dex_go/repositories/settings_repository.dart';
import 'package:hero_dex_go/repositories/collection_repository.dart';
import 'package:hero_dex_go/screens/auth/login_sreen.dart';
import 'package:hero_dex_go/screens/auth/register_screen.dart';
import 'package:hero_dex_go/screens/collection/user_collection_screen.dart';
import 'package:hero_dex_go/screens/hero/hero_screen.dart';
import 'package:hero_dex_go/screens/profile/settings_screen.dart';
import 'package:hero_dex_go/screens/search/search_screen.dart';
import 'package:hero_dex_go/screens/main_wrapper.dart';
import 'package:hero_dex_go/screens/onboarding/onboarding.dart';
import 'package:hero_dex_go/services/api_client.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final String key = 'onboarding';
  final String? onboardingJson = prefs.getString(key);
  bool onboardingCompleted = false;

  final bool analyticsEnabled =
      prefs.getBool('settings_analytics_enabled') ?? false;
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(
    analyticsEnabled,
  );
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    analyticsEnabled,
  );

  if (analyticsEnabled) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  if (onboardingJson != null) {
    try {
      final Map<String, dynamic> decodedMap = jsonDecode(onboardingJson);
      onboardingCompleted = decodedMap['onboarding_completed'] ?? false;
    } catch (e) {
      print(
        "DEBUG ERROR: Could not parse JSON: $e",
      ); // TODO: Replace with proper logging
    }
  } else {
    print("DEBUG: Did not find any data for key '$key'");
  }

  final String startRoute = onboardingCompleted ? '/login' : '/';

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>(create: (context) => ApiClient()),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(prefs: prefs),
        ),
        RepositoryProvider<SearchRepository>(
          create: (context) => SearchRepository(
            apiClient: context.read<ApiClient>(),
            prefs: prefs,
          ),
        ),
        RepositoryProvider<CollectionRepository>(
          create: (context) =>
              CollectionRepository(apiClient: context.read<ApiClient>()),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepository(prefs: prefs),
        ),
        RepositoryProvider<OnboardingRepository>(
          create: (context) => OnboardingRepository(prefs: prefs),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(
              settingsRepository: context.read<SettingsRepository>(),
            )..add(SettingsLoad()),
          ),
        ],
        child: MyApp(initialRoute: startRoute),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      initialLocation: widget.initialRoute,
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return OnboardingScreen();
          },
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginScreen();
          },
        ),
        GoRoute(
          path: '/register',
          builder: (BuildContext context, GoRouterState state) {
            return RegisterScreen();
          },
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
                  builder: (context, state) => const UserCollectionScreen(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/search',
                  builder: (context, state) => const SearchScreen(),
                  routes: [
                    GoRoute(
                      path: 'details/:id',
                      builder: (context, state) =>
                          HeroDetailScreen(heroId: state.pathParameters['id']),
                    ),
                  ],
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (context, state) => const SettingsScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'HeroDex GO',
          debugShowCheckedModeBanner: false,

          routerConfig: _router,

          themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,

          theme: ThemeData(
            brightness: .light,
            extensions: const <ThemeExtension<dynamic>>[
              ThemeColors(
                primaryColor: Color(0xFF7F0DF2),
                primaryTextColor: Color(0xFF000000),
                backgroundColor: Color(0xFFF7F5F8),
                cardBackgroundColor: Color(0xFFF0F0F0),
                containerColor: Color.fromARGB(255, 236, 234, 234),
              ),
            ],
          ),
          darkTheme: ThemeData.dark().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              const ThemeColors(
                primaryColor: Color(0xFF7F0DF2),
                primaryTextColor: Color(0xFFFFFFFF),
                backgroundColor: Color(0xFF191022),
                cardBackgroundColor: Color(0xFF2D2335),
                containerColor: Color(0xFF2B2036),
              ),
            ],
          ),
        );
      },
    );
  }
}
