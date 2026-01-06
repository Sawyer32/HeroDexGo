import 'package:flutter/material.dart' hide FilterChip;
import 'package:hero_dex_go/components/discovery/filter_chip.dart';
import 'package:hero_dex_go/models/hero_models.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';

class TrendingCard extends StatelessWidget {
  final String name;
  final String type;
  final String level;
  final bool topPick;

  const TrendingCard({super.key, required this.name, required this.type, required this.level, this.topPick = false});

  @override
  Widget build(BuildContext context) {
    final ThemeColors _themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/hero_image.png'), fit: .cover),
        borderRadius: .all(.circular(20)),
        shape: .rectangle
      ),
      height: 180,
      width: 120,
      child: Padding(
        padding: .all(8.0),
        child: Column(
          mainAxisAlignment: topPick ? .spaceBetween : .end,
          crossAxisAlignment: .start,
          children: [
            if (topPick)
              Container(
                padding: .directional(start: 10, top: 5, end: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: _themeColors.primaryColor,
                  borderRadius: .circular(20)
                ),
                child: Text("TOP PICK", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: .bold))
              ),
            Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                Text(name),
                Text("$type • Lvl $level")
              ],
            )
          ],
        ),
      )
    );
  }
}