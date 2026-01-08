import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/settings/settings_bloc.dart';
import 'package:hero_dex_go/bloc/settings/settings_event.dart';
import 'package:hero_dex_go/bloc/settings/settings_state.dart';
import 'package:hero_dex_go/components/profile/settings_switch_tile.dart';
import 'package:hero_dex_go/repositories/settings_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final containerColor = const Color(0xFF2B2036);
    final primaryColor = const Color(0xFF7F0DF2);

    return Scaffold(
      backgroundColor: const Color(0xFF191022),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 32, fontWeight: .bold, color: Colors.white
                ),
              ),
              const SizedBox(height: 30),

              _buildSectionHeader("Preferences", Icons.tune, primaryColor),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: .circular(20),
                ),
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        SettingsSwitchTile(
                          title: "Dark Mode",
                          icon: Icons.dark_mode,
                          iconColor: const Color(0xFF5E5CE6),
                          value: state.isDarkMode,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(SettingsToggleTheme(isDark: value));
                          }
                        )
                      ],
                    );
                  }
                )
              )
            ],
          )
        )
      )
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: .bold,
            letterSpacing: 1.2,
            fontSize: 12,
          )
        )
      ],
    );
  }
}