import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/collection/collection_bloc.dart';
import 'package:hero_dex_go/bloc/collection/collection_event.dart';
import 'package:hero_dex_go/bloc/collection/collection_state.dart';
import 'package:hero_dex_go/models/hero_models.dart';
import 'package:hero_dex_go/repositories/collection_repository.dart';
import 'package:hero_dex_go/theme/theme_extensions.dart';

class UserCollectionScreen extends StatelessWidget {
  const UserCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionBloc(
        collectionRepository: context.read<CollectionRepository>(),
      )..add(CollectionLoad()),
      child: const _UserCollectionView(),
    );
  }
}

class _UserCollectionView extends StatelessWidget {
  const _UserCollectionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Collection"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CollectionBloc>().add(CollectionLoad());
            },
          ),
        ],
      ),
      body: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "${state.collection.length} heroes collected",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: context.colors.primaryTextColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text("Sort By"),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.sort),
                        onPressed: () {
                          // TODO: Implement sorting
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(child: _buildHeroGrid(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroGrid(CollectionState state) {
    if (state.status == CollectionStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.status == CollectionStatus.failure) {
      return Center(
        child: Text("Error loading collection: ${state.errorMessage}"),
      );
    } else if (state.collection.isEmpty) {
      return const Center(child: Text("No heroes in collection"));
    }

    final heroes = state.collection;
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: heroes.length,
      itemBuilder: (context, index) {
        final hero = heroes[index];
        return _buildHeroCard(context, hero);
      },
    );
  }

  Widget _buildHeroCard(BuildContext context, HeroModel hero) {
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
