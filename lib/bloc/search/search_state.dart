import 'package:hero_dex_go/models/hero_models.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final SearchStatus status;
  final List<HeroModel> results;
  final List<String> previousSearches;
  final String errorMessage;

  SearchState({
    this.status = SearchStatus.initial,
    this.results = const [],
    this.previousSearches = const [],
    this.errorMessage = '',
  });

  SearchState copyWith({
    SearchStatus? status,
    List<HeroModel>? results,
    List<String>? previousSearches,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      previousSearches: previousSearches ?? this.previousSearches,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}