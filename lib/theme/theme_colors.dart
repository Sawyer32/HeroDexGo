import 'package:flutter/material.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({required this.primaryColor, required this.backgroundColor});

  final Color? primaryColor;
  final Color? backgroundColor;

  @override
  ThemeColors copyWith({Color? primaryColor, Color? backgroundColor}) {
    return ThemeColors(primaryColor: primaryColor ?? this.primaryColor, backgroundColor: backgroundColor ?? this.backgroundColor);
  }
  
  @override
  ThemeExtension<ThemeColors> lerp(covariant ThemeExtension<ThemeColors>? other, double t) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }

  // Optional
  @override
  String toString() => 'ThemeColors(primaryColor: $primaryColor, backgroundLight: $backgroundColor)';

}