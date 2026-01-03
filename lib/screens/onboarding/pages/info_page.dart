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

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: _themeColors.backgroundColor
        ),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .stretch,
          children: [
            Text("HeroDex GO", textAlign: .center,),
            SizedBox(height: 20),
            Padding(
              padding: .directional(start: 10, end: 10), 
              child: Image(
                image: AssetImage('assets/images/Onboarding_1.png')
                ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Text("Knowledge is Power.", style: TextStyle(fontSize: 24),),
                Text("Collection is Glory.", style: TextStyle(color: _themeColors.primaryColor, fontSize: 24),),
                SizedBox(height: 20),
                Padding(
                  padding: .directional(start: 10, end: 10),
                  child: 
                    Text(
                    "Discover thousands of supersheroes. Analyze their stats, alignment, and origins. Your journey to becoming the ultimate archivist starts here.",
                    textAlign: .center,
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 24),
            Padding(
              padding: .directional(start: 10, end: 10),
              child: FloatingActionButton(
                backgroundColor: _themeColors.primaryColor,
                onPressed: () => {
                  context.read<OnboardingBloc>().add(OnboardingNextPage()),
                },
                child: Text("Start Scanning", style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 10),
            Text("Already have an account? Log in", textAlign: .center),
          ]
        ),
      ),
    );
  }
}