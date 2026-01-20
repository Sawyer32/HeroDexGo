import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key, required this.context});

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
                  Text("HeroDex GO", textAlign: TextAlign.center, style: TextStyle(fontSize: isMobile ? 28 : 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: isMobile ? 20 : 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding), 
                    child: Image(
                      image: AssetImage('assets/images/Onboarding_1.png'),
                      height: isMobile ? 200 : 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        Text("Knowledge is Power.", style: TextStyle(fontSize: isMobile ? 24 : 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        Text("Collection is Glory.", style: TextStyle(color: _themeColors.primaryColor, fontSize: isMobile ? 24 : 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        Text(
                          "Discover thousands of supersheroes. Analyze their stats, alignment, and origins. Your journey to becoming the ultimate archivist starts here.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 15 : 16,
                            height: 1.5,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 24 : 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        backgroundColor: _themeColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        context.read<OnboardingBloc>().add(OnboardingNextPage());
                      },
                      child: Text("Start Scanning", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Text("Already have an account? Log in", textAlign: TextAlign.center, style: TextStyle(fontSize: isMobile ? 14 : 15)),
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