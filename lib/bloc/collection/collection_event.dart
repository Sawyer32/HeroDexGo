import 'package:equatable/equatable.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class CollectionLoad extends CollectionEvent {}

class CollectionRefresh extends CollectionEvent {}
