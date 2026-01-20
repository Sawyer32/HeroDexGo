import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class GpsPage extends StatelessWidget {
  const GpsPage({super.key}); 

  @override
  Widget build(BuildContext context) {
    final ThemeColors? themeColors = Theme.of(context).extension<ThemeColors>();
    final Color bgColor = themeColors?.backgroundColor ?? Colors.white;
    final Color primaryColor = themeColors?.primaryColor ?? Colors.blue;
    final isMobile = MediaQuery.of(context).size.width < 600;
    final horizontalPadding = isMobile ? 20.0 : 40.0;
    final maxWidth = isMobile ? double.infinity : 500.0;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
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
                      image: AssetImage('assets/images/LoginImage.png'),
                      height: isMobile ? 150 : 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        Text("Scout Your", style: TextStyle(fontSize: isMobile ? 28 : 32, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        Text(
                          "Surroundings", 
                          style: TextStyle(fontSize: isMobile ? 28 : 32, fontWeight: FontWeight.bold, color: primaryColor), 
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "To find heroes and villains hiding in your city, we need access to your location. "
                          "This lets you participate in location-based activities.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: isMobile ? 15 : 16, height: 1.5),
                        ),
                        SizedBox(height: isMobile ? 20 : 24),
                        _buildInfoBox(Icons.radar_rounded, "Spot nearby villains", "See who is lurking...", primaryColor, isMobile),
                        SizedBox(height: isMobile ? 12 : 16),
                        _buildInfoBox(Icons.people_alt_rounded, "Join forces", "Find other heroes...", primaryColor, isMobile),
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
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            context.read<OnboardingBloc>().add(OnboardingRequestLocation());
                          },
                          child: Text("Enable Location Services", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        SizedBox(height: 12),
                        FilledButton.tonal(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.black45,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            context.read<OnboardingBloc>().add(OnboardingCompleted());
                          },
                          child: Text("Maybe Later", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Text("Read our full Privacy Policy", textAlign: TextAlign.center, style: TextStyle(fontSize: isMobile ? 14 : 15)),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String subtitle, Color color, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Icon(icon, size: isMobile ? 24.0 : 28.0, color: color),
          SizedBox(width: isMobile ? 10 : 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 14 : 15)),
                Text(subtitle, style: TextStyle(fontSize: isMobile ? 13 : 14)),
              ],
            ),
          )
        ],
      ),
    );
  }
}