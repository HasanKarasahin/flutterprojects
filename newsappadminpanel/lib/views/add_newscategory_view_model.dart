import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/newscategory_model.dart';
import 'package:newsappadminpanel/services/database.dart';

class AddNewsCategoryViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'NewsCategory';

  Future<void> addNewsCategory(
      {required String categoryName,
      required String categoryUrl,
      required String categoryIcon}) async {
    /// Form alanındaki verileri ile önce bir newscategory objesi oluşturulması
    NewsCategoryModel newBook = NewsCategoryModel(
        id: DateTime.fromMillisecondsSinceEpoch(1560343627 * 1000).toString(),
        categoryName: categoryName,
        categoryUrl: categoryUrl,
        categoryIcon: "a");

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setTabData(
        collectionPath: collectionPath, newscategoryAsMap: newBook.toMap());
  }
}
