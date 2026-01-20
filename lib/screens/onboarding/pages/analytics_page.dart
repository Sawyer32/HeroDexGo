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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final horizontalPadding = isMobile ? 20.0 : 40.0;
    final maxWidth = isMobile ? double.infinity : 500.0;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: _themeColors.backgroundColor
        ),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding), 
                    child: Image(
                      image: AssetImage('assets/images/Onboarding_2.png'),
                      height: isMobile ? 200 : 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        Text("Your Privacy Matters", style: TextStyle(fontSize: isMobile ? 28 : 32, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        Text(
                          "Help us make the ultimate hero database. We use anonymous analytics and crash reporting to fix bugs faster. We never collect personal data without your permission.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: isMobile ? 15 : 16, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 32 : 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FilledButton.tonal(
                          style: FilledButton.styleFrom(
                            backgroundColor: _themeColors.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            context.read<OnboardingBloc>().add(OnboardingAnalyticsChanged(true));
                          },
                          child: Text("Allow Analytics", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        SizedBox(height: 12),
                        FilledButton.tonal(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.black45,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            context.read<OnboardingBloc>().add(OnboardingAnalyticsChanged(false));
                          },
                          child: Text("Ask App Not to Track", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    )
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Text("Read our full Privacy Policy", textAlign: TextAlign.center, style: TextStyle(fontSize: isMobile ? 14 : 15)),
                  ),
                  SizedBox(height: 20),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}