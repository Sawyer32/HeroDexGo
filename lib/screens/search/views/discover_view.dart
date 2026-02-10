import 'package:flutter/material.dart' hide FilterChip;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/collection/collection_bloc.dart';
import 'package:hero_dex_go/bloc/collection/collection_state.dart';
import 'package:hero_dex_go/components/collection_stat_card.dart';
import 'package:hero_dex_go/components/discovery/recent_searches.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "YOUR COLLECTION",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<CollectionBloc, CollectionState>(
            builder: (context, state) {
              final collectedCount = state.collection.length;

              double totalStrength = 0;
              for (var hero in state.collection) {
                final strengthStr = hero.powerstats?.strength ?? "0";
                final strength = double.tryParse(strengthStr) ?? 0;
                totalStrength += strength;
              }

              String strengthDisplay = totalStrength.toInt().toString();
              if (totalStrength >= 1000) {
                strengthDisplay =
                    "${(totalStrength / 1000).toStringAsFixed(1)}k";
              }

              return Row(
                children: [
                  Expanded(
                    child: CollectionStatCard(
                      label: "COLLECTED",
                      value: collectedCount.toString(),
                      icon: Icons.groups,
                      backgroundColor: const Color(
                        0xFF7F0DF2,
                      ), // Primary Purple
                      backgroundIcon: const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CollectionStatCard(
                      label: "TOTAL POWER",
                      value: strengthDisplay,
                      icon: Icons.flash_on,
                      backgroundColor: const Color(
                        0xFF2D2335,
                      ), // Dark Card Color
                      backgroundIcon: const Icon(
                        Icons.speed,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          const RecentSearches(),
        ],
      ),
    );
  }
}
