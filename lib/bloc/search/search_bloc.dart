import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/search/search_event.dart';
import 'package:hero_dex_go/bloc/search/search_state.dart';
import 'package:hero_dex_go/repositories/search_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;

  SearchBloc({required SearchRepository searchRepository}) : _searchRepository = searchRepository, super(SearchState()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: (events, mapper) {
        return events
          .debounceTime(const Duration(milliseconds: 300)) // Vänta 300ms innan sökning
          .distinct() // Ignorera om det är exakt samma text som nyss
          .switchMap(mapper); // switchMap avbryter gamla sökningar om en ny sökning kommer
      },
    );
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query;

    if (query.isEmpty) {
      emit(state.copyWith(status: SearchStatus.initial, results: []));
      return;
    }

    if (query.length < 2) return;

    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final results = await _searchRepository.search(query);

      if (results.isEmpty) {
        emit(state.copyWith(status: SearchStatus.success, results: []));
      } else {
        emit(state.copyWith(status: SearchStatus.success, results: results));
      }
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure, errorMessage: e.toString()));
    }
  }
}