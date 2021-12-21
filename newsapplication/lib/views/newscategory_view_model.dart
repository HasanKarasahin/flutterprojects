import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/models/newscategory_model.dart';
import 'package:newsapplication/services/database.dart';

class NewsCategoryViewModel extends ChangeNotifier {
  String _collectionPath = 'NewsCategory';

  Database _database = Database();

  Stream<List<NewsCategoryModel>> getCategoryList() {
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getNewsCategoryListFromApi(_collectionPath)
        .map((querySnapshot) => querySnapshot.docs);

    Stream<List<NewsCategoryModel>> streamListNewsCategory =
        streamListDocument.map((listOfDocSnap) => listOfDocSnap
            .map((docSnap) => NewsCategoryModel.fromMap({
                  "id": docSnap["id"],
                  "categoryName": docSnap["categoryName"],
                  "categoryUrl": docSnap["categoryUrl"],
                  "categoryIcon": docSnap["categoryIcon"],
                }))
            .toList());

    return streamListNewsCategory;
  }
}
