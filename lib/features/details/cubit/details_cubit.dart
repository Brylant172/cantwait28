import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:cantwait28/repository/items_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(const DetailsState());

  final _itemsRepository = ItemsRepository();

  Future<void> getItemWithID(String itemID) async {
    emit(const DetailsState(isLoading: true));
    try {
      final itemModel = await _itemsRepository.getItemWithID(itemID);
      emit(DetailsState(itemModel: itemModel));
    } catch (error) {
      emit(
        const DetailsState(
          loadingErrorOccured: true,
        ),
      );
    }
  }
}
