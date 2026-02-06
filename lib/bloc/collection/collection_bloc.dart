import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/collection/collection_event.dart';
import 'package:hero_dex_go/bloc/collection/collection_state.dart';
import 'package:hero_dex_go/repositories/collection_repository.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final CollectionRepository collectionRepository;

  CollectionBloc({required this.collectionRepository})
    : super(const CollectionState()) {
    on<CollectionLoad>(_onCollectionLoad);
    on<CollectionRefresh>(_onCollectionRefresh);
  }

  Future<void> _onCollectionLoad(
    CollectionLoad event,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(status: CollectionStatus.loading));
    try {
      final collection = await collectionRepository.getCollection();
      emit(
        state.copyWith(
          status: CollectionStatus.success,
          collection: collection,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCollectionRefresh(
    CollectionRefresh event,
    Emitter<CollectionState> emit,
  ) async {
    // We can just trigger a load again, or keep current data while loading
    // For now, let's just reuse the load logic but maybe we don't clear the list first
    add(CollectionLoad());
  }
}
