import 'package:flutter/material.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';


class FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const FilterChip({super.key, required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final ThemeColors _themeColors = Theme.of(context).extension<ThemeColors>()!;
    return Container(
    margin: .only(right: 10),
    padding: .symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
      color: isActive ? _themeColors.primaryColor : const Color(0xFF2B2036),
      borderRadius: .circular(20)
    ),
    child: Text(label, style: const TextStyle(color: Colors.white))
  );
  }
}