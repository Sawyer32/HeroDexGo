abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}

class RemoveItemFromHistory extends SearchEvent {
  final String query;
  RemoveItemFromHistory(this.query);
}

class SearchLoadHistory extends SearchEvent {}