import 'package:flutter/material.dart' hide FilterChip;
import 'package:hero_dex_go/components/discovery/filter_chip.dart';
import 'package:hero_dex_go/components/discovery/recent_searches.dart';
import 'package:hero_dex_go/components/discovery/trending_card.dart';

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
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text("Trending", style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 32)),
            TextButton(
              child: Text("View all"),
              onPressed: () => {},
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 15,
            children: [
              TrendingCard(name: "Dr. Dread", type: "Villain", level: "10", topPick: false,),
              TrendingCard(name: "Dr. Dread", type: "Villain", level: "10", topPick: false,),
              TrendingCard(name: "Dr. Dread", type: "Villain", level: "10", topPick: true,),
              TrendingCard(name: "Dr. Dread", type: "Villain", level: "10", topPick: false,),
              TrendingCard(name: "Dr. Dread", type: "Villain", level: "10", topPick: false,),
            ],
          )
        ),
        RecentSearches(),
      ],
    )
  );
}