import 'package:equatable/equatable.dart';
import 'package:hero_dex_go/models/hero_models.dart';

enum CollectionStatus { initial, loading, success, failure }

class CollectionState extends Equatable {
  final CollectionStatus status;
  final List<HeroModel> collection;
  final String? errorMessage;

  const CollectionState({
    this.status = CollectionStatus.initial,
    this.collection = const [],
    this.errorMessage,
  });

  CollectionState copyWith({
    CollectionStatus? status,
    List<HeroModel>? collection,
    String? errorMessage,
  }) {
    return CollectionState(
      status: status ?? this.status,
      collection: collection ?? this.collection,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, collection, errorMessage];
}
