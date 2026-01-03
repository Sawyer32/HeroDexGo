import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_state.dart';
import 'package:hero_dex_go/screens/onboarding/pages/analytics_page.dart';
import 'package:hero_dex_go/screens/onboarding/pages/gps_page.dart';
import 'package:hero_dex_go/screens/onboarding/pages/info_page.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: Scaffold(
        body: BlocConsumer<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            pageController.animateToPage(
              state.pageIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );

            // If onboarding is completed
            if (state.isCompleted) {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Page 1: Info
                      InfoPage(context: context),
                      // Page 2: Analytics
                      AnalyticsPage(context: context),
                      // Page 3: GPS
                      GpsPage(context: context)
                    ]
                  )
                )
              ],
            );
          }
        )
      )
    );
  }
}