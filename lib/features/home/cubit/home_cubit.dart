import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cantwait28/features/home/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription =
        FirebaseFirestore.instance.collection('items').snapshots().listen(
      (itemsRaw) {
        final items = itemsRaw.docs
            .map(
              (item) => ItemModel(
                imageURL: item['image_url'],
                title: item['title'],
                releaseDate: DateFormat.yMMMd().format(
                  (item['release_date'] as Timestamp).toDate(),
                ),
              ),
            )
            .toList();
        emit(HomeState(items: items));
      },
    )..onError((error) {});
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
