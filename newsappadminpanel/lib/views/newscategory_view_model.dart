import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/newscategory_model.dart';
import 'package:newsappadminpanel/services/database.dart';

class CategoryViewModel extends ChangeNotifier {
  String _collectionPath = 'NewsCategory';

  Database _database = Database();

  Stream<List<NewsCategoryModel>> getCategoryList() {
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getTabListFromApi(_collectionPath)
        .map((querySnapshot) => querySnapshot.docs);

    Stream<List<NewsCategoryModel>> streamListBook =
        streamListDocument.map((listOfDocSnap) => listOfDocSnap
            .map((docSnap) => NewsCategoryModel.fromMap({
                  "id": docSnap["id"],
                  "categoryName": docSnap["categoryName"],
                  "categoryUrl": docSnap["categoryUrl"],
                  "categoryIcon": docSnap["categoryIcon"],
                }))
            .toList());

    return streamListBook;
  }

  Future<void> deleteBook(NewsCategoryModel newsCategoryModel) async {
    await _database.deleteDocument(
        referecePath: _collectionPath, id: newsCategoryModel.id);
  }
}
