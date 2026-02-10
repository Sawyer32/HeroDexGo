import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/settings/settings_bloc.dart';
import 'package:hero_dex_go/bloc/settings/settings_event.dart';
import 'package:hero_dex_go/bloc/settings/settings_state.dart';
import 'package:hero_dex_go/components/profile/settings_switch_tile.dart';
import 'package:hero_dex_go/repositories/settings_repository.dart';
import 'package:hero_dex_go/theme/theme_extensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: .bold,
                  color: context.colors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 30),

              _buildSectionHeader(
                "Preferences",
                Icons.tune,
                context.colors.primaryTextColor,
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: context.colors.containerColor,
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
                            context.read<SettingsBloc>().add(
                              SettingsToggleTheme(isDark: value),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            height: 1,
                            color: context.colors.primaryTextColor?.withValues(
                              alpha: 0.1,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<SettingsBloc>().add(
                              SettingsToggleAnalytics(
                                newVaule: !state.analyticsEnabled,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.analytics_outlined,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    "Analytics",
                                    style: TextStyle(
                                      color: context.colors.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: state.analyticsEnabled
                                        ? Colors.green.withValues(alpha: 0.2)
                                        : Colors.red.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    state.analyticsEnabled
                                        ? "Active"
                                        : "Inactive",
                                    style: TextStyle(
                                      color: state.analyticsEnabled
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: context.colors.containerColor,
                  borderRadius: .circular(20),
                ),
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: .start,
                            mainAxisAlignment: .start,
                            children: [
                              Text(
                                "HeroDexGo information",
                                style: TextStyle(
                                  color: context.colors.primaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    "Version",
                                    style: TextStyle(
                                      color: context.colors.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "0.0.1-alpha",
                                    style: TextStyle(
                                      color: context.colors.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    "Creator",
                                    style: TextStyle(
                                      color: context.colors.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Jesper Hunesjö",
                                    style: TextStyle(
                                      color: context.colors.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    "Year",
                                    style: TextStyle(
                                      color: context.colors.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "2026",
                                    style: TextStyle(
                                      color: context.colors.primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color? color) {
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
          ),
        ),
      ],
    );
  }
}
