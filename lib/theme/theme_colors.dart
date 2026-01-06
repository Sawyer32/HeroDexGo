import 'package:flutter/material.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({required this.primaryColor, required this.primaryTextColor, required this.backgroundColor, required this.cardBackgroundColor});

  final Color? primaryColor;
  final Color? primaryTextColor;
  final Color? backgroundColor;
  final Color? cardBackgroundColor;

  @override
  ThemeColors copyWith({Color? primaryColor, Color? primaryTextColor, Color? backgroundColor, Color? cardBackgroundColor}) {
    return ThemeColors(primaryColor: primaryColor ?? this.primaryColor, primaryTextColor: primaryTextColor ?? this.primaryTextColor, backgroundColor: backgroundColor ?? this.backgroundColor, cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor);
  }
  
  @override
  ThemeExtension<ThemeColors> lerp(covariant ThemeExtension<ThemeColors>? other, double t) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      cardBackgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t),
    );
  }

  // Optional
  @override
  String toString() => 'ThemeColors(primaryColor: $primaryColor, backgroundLight: $backgroundColor)';

}