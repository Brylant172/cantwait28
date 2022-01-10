import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemsRepository {
  Future<ItemModel> getItemWithID(String itemID) async {
    await Future.delayed(const Duration(seconds: 1));
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(itemID)
        .get();
    final itemModel = ItemModel.createFromDocumentSnapshot(doc);
    return itemModel;
  }

  Stream<List<ItemModel>> getItemsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .map(
      (itemsRaw) {
        final items = itemsRaw.docs.map(
          (doc) {
            return ItemModel.createFromDocumentSnapshot(doc);
          },
        ).toList();
        return items;
      },
    );
  }
}
