import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    _streamSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .listen(
      (itemsRaw) {
        final items = itemsRaw.docs
            .map(
              (item) => ItemModel(
                id: item.id,
                imageURL: item['image_url'],
                title: item['title'],
                releaseDate: (item['release_date'] as Timestamp).toDate(),
              ),
            )
            .toList();
        emit(HomeState(items: items));
      },
    )..onError(
        (error) {
          emit(const HomeState(loadingErrorOccured: true));
        },
      );
  }

  Future<void> remove(ItemModel model) async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('items')
          .doc(model.id)
          .delete();
    } catch (error) {
      emit(
        const HomeState(
          removingErrorOccured: true,
        ),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
