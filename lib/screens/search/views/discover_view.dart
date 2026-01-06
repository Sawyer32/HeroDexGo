import 'package:flutter/material.dart' hide FilterChip;
import 'package:hero_dex_go/components/discovery/filter_chip.dart';

Widget buildDiscoverView(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: .start,
      children: [
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            children: [
              FilterChip(label: "All", isActive: true),
              FilterChip(label: "Heroes", isActive: false),
              FilterChip(label: "Villains", isActive: false),
              FilterChip(label: "Aliens", isActive: false),
            ],
          )
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            // TODO: Trending Hero Card
          )
        )
      ],
    )
  );
}