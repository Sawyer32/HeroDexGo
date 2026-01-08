import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/bloc/search/search_bloc.dart';
import 'package:hero_dex_go/bloc/search/search_event.dart';
import 'package:hero_dex_go/bloc/search/search_state.dart';
import 'package:hero_dex_go/repositories/search_repository.dart';
import 'package:hero_dex_go/screens/search/views/discover_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(searchRepository: context.read<SearchRepository>()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: .all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const Text(
                  "Discover",
                  style: TextStyle(fontSize: 32, fontWeight: .bold, color: Colors.white)
                ),
                const SizedBox(height: 16),
          
                _buildSearchBar(context),
                SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state.status == SearchStatus.loading ||
                        state.status == SearchStatus.success ||
                        (state.status == SearchStatus.initial && state.results.isNotEmpty)) {
                          return _buildSearchResults(state);
                      }
          
                      return buildDiscoverView(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search for a hero...",
        prefixIcon: Icon(Icons.search),
        border: .none,
        filled: true,
      ),
      onChanged: (text) {
        context.read<SearchBloc>().add(SearchQueryChanged(text));
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  Widget _buildSearchResults(SearchState state) {
  if (state.status == SearchStatus.loading) {
    return const Center(child: CircularProgressIndicator());
  }
  
  if (state.results.isEmpty && state.status != SearchStatus.initial) {
     return const Center(child: Text("No heroes found.", style: TextStyle(color: Colors.white)));
  }

  if (state.results.isEmpty) {
      return const SizedBox.shrink(); 
  }

  return ListView.builder(
      itemCount: state.results.length,
      itemBuilder: (context, index) {
        final hero = state.results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: (hero.image?.url != null) ? NetworkImage(hero.image!.url!) : null,
          ),
          title: Text(hero.name, style: const TextStyle(color: Colors.white)),
          subtitle: Text(hero.biography?.alterEgo.join(", ") ?? "", style: TextStyle(color: Colors.grey[400])),
          onTap: () {
            context.go("/details/${hero.id}");
          },
        );
      },
    );
  }
}