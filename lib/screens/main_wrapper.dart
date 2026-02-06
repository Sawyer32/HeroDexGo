import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class MainWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final ThemeColors? themeColors = Theme.of(context).extension<ThemeColors>();
    
    // Fallback om theme extension saknas (för att undvika krasch)
    final Color bgColor = themeColors?.backgroundColor ?? Colors.white;
    final Color primaryColor = themeColors?.primaryColor ?? Colors.blue;

    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex
          );
        },
        selectedItemColor: primaryColor,
        selectedIconTheme: IconThemeData(color: primaryColor),
        backgroundColor: bgColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_sharp),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_sharp),
            label: 'Search'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Settings'
          )
        ]
      ),
    );
  }
}