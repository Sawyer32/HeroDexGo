import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final ThemeColors _themeColors = Theme.of(context).extension<ThemeColors>()!;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: _themeColors.backgroundColor
        ),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .stretch,
          children: [
            Padding(
              padding: .directional(start: 10, end: 10), 
              child: Image(
                image: AssetImage('assets/images/Onboarding_2.png'),
                height: 280,
                fit: .cover,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: .directional(start: 10, end: 10),
              child: Column(
                children: [
                  Text("Your Privacy Matters", style: TextStyle(fontSize: 32, fontWeight: .bold)),
                  SizedBox(height: 20),
                  Text("Help us make the ultimate hero database. We use anonymous analytics and crash reporting to fix bugs faster. We never collect personal data without your permission.", textAlign: .center,),
                ],
              ),
            ),
            SizedBox(height: 36),
            Padding(
              padding: .directional(start: 10, end: 10),
              child: Column(
                crossAxisAlignment: .stretch,
                spacing: 20,
                children: [
                  FloatingActionButton(
                    backgroundColor: _themeColors.primaryColor,
                    onPressed: () => {
                      context.read<OnboardingBloc>().add(OnboardingAnalyticsChanged(true)),
                    },
                    child: Text("Allow Analytics", style: TextStyle(color: Colors.white),),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.black45,
                    onPressed: () => {
                      context.read<OnboardingBloc>().add(OnboardingAnalyticsChanged(false)),
                    },
                    child: Text("Ask App Not to Track", style: TextStyle(color: Colors.white),),
                  ),
                ],
              )
            ),
            SizedBox(height: 10),
            Text("Read our full Privacy Policy", textAlign: .center),
          ]
        ),
      ),
    );
  }
}