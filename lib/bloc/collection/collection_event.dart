import 'package:equatable/equatable.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class CollectionLoad extends CollectionEvent {}

class CollectionRefresh extends CollectionEvent {}

class CollectionRemoveHero extends CollectionEvent {
  final String heroId;

  const CollectionRemoveHero(this.heroId);

  @override
  List<Object> get props => [heroId];
}
