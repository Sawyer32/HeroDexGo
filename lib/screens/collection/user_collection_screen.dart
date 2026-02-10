import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/collection/collection_bloc.dart';
import 'package:hero_dex_go/bloc/collection/collection_event.dart';
import 'package:hero_dex_go/bloc/collection/collection_state.dart';
import 'package:hero_dex_go/components/hero_card.dart';
import 'package:hero_dex_go/theme/theme_extensions.dart';

class UserCollectionScreen extends StatelessWidget {
  const UserCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _UserCollectionView();
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
                        onPressed: () {},
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
        return Dismissible(
          key: Key(hero.id ?? ""),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Delete Hero?"),
                  content: Text(
                    "Are you sure you want to remove ${hero.name} from your collection?",
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("CANCEL"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text(
                        "DELETE",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) {
            if (hero.id != null) {
              context.read<CollectionBloc>().add(
                CollectionRemoveHero(hero.id!),
              );
            }
          },
          child: HeroCard(hero: hero),
        );
      },
    );
  }
}
