import 'package:flutter/material.dart';
import 'package:hero_dex_go/models/hero_models.dart';
import 'package:hero_dex_go/theme/theme_extensions.dart';

class HeroCard extends StatelessWidget {
  final HeroModel hero;

  const HeroCard({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colors.containerColor,
        border: Border.all(color: context.colors.containerColor!, width: 10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: hero.image != null
                  ? _buildHeroImageWidget(imageUrl: hero.image!.url)
                  : const Center(child: Icon(Icons.person, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hero.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImageWidget({required String imageUrl}) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }
}
