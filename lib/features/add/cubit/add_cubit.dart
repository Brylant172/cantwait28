import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(const AddState());

  Future<void> add(ItemModel item) async {
    try {
      final userID = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('items')
          .add(
        {
          'title': item.title,
          'image_url': item.imageURL,
          'release_date': item.releaseDate,
        },
      );
      emit(const AddState(saved: true));
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}
