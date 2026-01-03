import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class GpsPage extends StatelessWidget {
  // 1. Tog bort 'context' från constructorn
  const GpsPage({super.key}); 

  @override
  Widget build(BuildContext context) {
    // 2. Flyttade Theme-hämtingen in hit där den hör hemma
    final ThemeColors? themeColors = Theme.of(context).extension<ThemeColors>();
    
    // Fallback om theme extension saknas (för att undvika krasch)
    final Color bgColor = themeColors?.backgroundColor ?? Colors.white;
    final Color primaryColor = themeColors?.primaryColor ?? Colors.blue;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              // 3. Rättade padding-syntaxen (standard Flutter)
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10), 
              child: Image(
                image: AssetImage('assets/images/LoginImage.png'),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: Column(
                children: [
                  const Text("Scout Your", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Text(
                    "Surroundings", 
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryColor), 
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "To find heroes and villains hiding in your city, we need access to your location. "
                    "This lets you participate in location-based activites.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  
                  // Dina info-boxar (förenklad layout för läsbarhet)
                  _buildInfoBox(Icons.radar_rounded, "Spot nearby villains", "See who is lurking...", primaryColor),
                  const SizedBox(height: 10),
                  _buildInfoBox(Icons.people_alt_rounded, "Join forces", "Find other heroes...", primaryColor),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // spacing: 20, // (Kräver nyaste Flutter versionen, använd SizedBox om det klagar)
                children: [
                  FloatingActionButton.extended(
                    heroTag: "btn_enable_location", // 4. VIKTIGT: Unik tagg
                    backgroundColor: primaryColor,
                    onPressed: () {
                      context.read<OnboardingBloc>().add(OnboardingRequestLocation());
                    },
                    label: const Text("Enable Location Services", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton.extended(
                    heroTag: "btn_maybe_later", // 4. VIKTIGT: Unik tagg
                    backgroundColor: Colors.black45,
                    onPressed: () {
                      // 5. Korrekt syntax med måsvingar för blocket
                      context.read<OnboardingBloc>().add(OnboardingCompleted());
                    },
                    label: const Text("Maybe Later", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text("Read our full Privacy Policy", textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // Hjälpmetod för att städa upp koden lite
  Widget _buildInfoBox(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24.0, color: color),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle),
              ],
            ),
          )
        ],
      ),
    );
  }
}