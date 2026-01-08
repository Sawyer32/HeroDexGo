import 'package:flutter/material.dart';
import 'package:hero_dex_go/theme/theme_extensions.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: .all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.2),
              shape: .circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: context.colors.primaryTextColor,
                fontSize: 16,
                fontWeight: .w500
              ),
            ),
          ),

          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: iconColor,
          )
        ],
      )
    );
  }
}