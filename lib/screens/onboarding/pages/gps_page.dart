import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class GpsPage extends StatelessWidget {
  const GpsPage({super.key, required this.context});

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
                image: AssetImage('assets/images/LoginImage.png'),
                height: 200,
                fit: .cover,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: .directional(start: 10, end: 10),
              child: Column(
                children: [
                  Text("Scout Your", style: TextStyle(fontSize: 32, fontWeight: .bold)),
                  Text("Surroundings", style: TextStyle(fontSize: 32, fontWeight: .bold, color: _themeColors.primaryColor), textAlign: .center,),
                  SizedBox(height: 20),
                  Text(
                    "To find heroes and villains hiding in your city, we need access to your location. "
                    "This lets you participate in location-based activites.",
                    textAlign: .center,
                  ),
                  
                   Column(
                      spacing: 20,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                            border: .all(width: 1),
                            borderRadius: .all(.circular(10))
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.radar_rounded,
                                size: 24.0,
                                color: _themeColors.primaryColor,
                                semanticLabel: 'Radar icon',
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Text("Spot nearby villains", textAlign: .left),
                                    Text("See who is lurking around your neighborhood in real-time.")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                            border: .all(width: 1),
                            borderRadius: .all(.circular(10))
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people_alt_rounded,
                                color: _themeColors.primaryColor,
                                size: 24.0,
                                semanticLabel: 'Radar icon',
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Text("Spot nearby villains", textAlign: .left),
                                    Text("See who is lurking around your neighborhood in real-time.")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
                      context.read<OnboardingBloc>().add(OnboardingRequestLocation()),
                    },
                    child: Text("Enable Location Services", style: TextStyle(color: Colors.white),),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.black45,
                    onPressed: () => {
                      context.read<OnboardingBloc>().add(OnboardingCompleted())
                    },
                    child: Text("Maybe Later", style: TextStyle(color: Colors.white),),
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