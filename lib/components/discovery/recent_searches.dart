import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/search/search_bloc.dart';
import 'package:hero_dex_go/bloc/search/search_event.dart';
import 'package:hero_dex_go/bloc/search/search_state.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.previousSearches.isNotEmpty) {
            return Column(
              crossAxisAlignment: .start,
              children: [
                const Padding(
                  padding: .symmetric(vertical: 16.0),
                  child: Text("Recent Searches", style: TextStyle(color: Colors.white, fontWeight: .bold))
                ),
                _previousSearchPhrases(context, state)
              ],
            );
          }

          return const SizedBox.shrink();
        }
      );
  }

  Widget _previousSearchPhrases(BuildContext context, SearchState state) {
    return Column(
      children: [
        for (var element in state.previousSearches)
          _buildHistoryItem(context, element),
      ],
    );
  }

  Widget _buildHistoryItem(BuildContext context, String text) {
    return ListTile(
      contentPadding: .zero,
      dense: true,
      leading: Container(
        padding: .all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF2B2036),
          borderRadius: .circular(8)
        ),
        child: const Icon(Icons.history, color: Colors.grey, size: 20),
      ),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      trailing: IconButton(
        icon: const Icon(Icons.close, color: Colors.grey, size: 18),
        onPressed: () {
          // TODO: Event to remove item from recent search
          context.read<SearchBloc>().add(RemoveItemFromHistory(text));
        },
      ),
      onTap: () {
        // To search again
        context.read<SearchBloc>().add(SearchQueryChanged(text));
      }
    );
  }
}