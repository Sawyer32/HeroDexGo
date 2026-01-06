import 'package:hero_dex_go/models/hero_models.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final SearchStatus status;
  final List<HeroModel> results;
  final String errorMessage;

  SearchState({
    this.status = SearchStatus.initial,
    this.results = const [],
    this.errorMessage = '',
  });

  SearchState copyWith({
    SearchStatus? status,
    List<HeroModel>? results,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}