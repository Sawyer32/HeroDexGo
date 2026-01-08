import 'package:flutter/material.dart';

import 'theme_colors.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  ThemeColors get colors => theme.extension<ThemeColors>()!;

  TextTheme get text => theme.textTheme;
}