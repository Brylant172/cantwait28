import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(const DetailsState());

  Future<void> getItemWithID(String itemID) async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('items')
          .doc(itemID)
          .get();
      final itemModel = ItemModel.createFromDocumentSnapshot(result);
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
