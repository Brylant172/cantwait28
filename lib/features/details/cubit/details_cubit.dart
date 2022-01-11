import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(const DetailsState());

  Future<void> getItemWithID(String itemID) async {
    emit(const DetailsState(isLoading: true));
    try {
      await Future.delayed(const Duration(seconds: 1));
      final doc = await FirebaseFirestore.instance
          .collection('items')
          .doc(itemID)
          .get();
      final itemModel = ItemModel.createFromDocumentSnapshot(doc);
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
