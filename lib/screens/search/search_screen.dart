import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/bloc/search/search_bloc.dart';
import 'package:hero_dex_go/bloc/search/search_event.dart';
import 'package:hero_dex_go/bloc/search/search_state.dart';
import 'package:hero_dex_go/repositories/search_repository.dart';
import 'package:hero_dex_go/screens/search/views/discover_view.dart';
import 'package:hero_dex_go/theme/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hero_dex_go/theme/theme_extensions.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc(searchRepository: context.read<SearchRepository>()),
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
              Text(
                "Discover",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: .bold,
                  color: context.colors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 16),

              _buildSearchBar(context),
              SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.status == SearchStatus.loading ||
                        state.status == SearchStatus.success ||
                        (state.status == SearchStatus.initial &&
                            state.results.isNotEmpty)) {
                      return _buildSearchResults(state);
                    }

                    return const DiscoverView();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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

    if (state.results.isEmpty &&
        state.status != SearchStatus.initial &&
        state.status != SearchStatus.failure) {
      return const Center(
        child: Text("No heroes found.", style: TextStyle(color: Colors.white)),
      );
    }

    if (state.status == SearchStatus.failure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                "Oops! Something went wrong.",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.errorMessage.isNotEmpty
                    ? state.errorMessage
                    : "An unknown error occurred.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      );
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
            backgroundImage: (hero.image?.url != null)
                ? NetworkImage(hero.image!.url!)
                : null,
          ),
          title: Text(hero.name, style: const TextStyle(color: Colors.white)),
          subtitle: Text(
            hero.biography?.alterEgo.join(", ") ?? "",
            style: TextStyle(color: Colors.grey[400]),
          ),
          onTap: () {
            context.go("/search/details/${hero.id}");
          },
        );
      },
    );
  }
}
