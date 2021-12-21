import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/newscategory_model.dart';
import 'package:newsappadminpanel/services/database.dart';

class UpdateNewsCategoryViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'NewsCategory';

  Future<void> updateNewsCategory(
      {required String categoryName,
      required String categoryUrl,
      required String categoryIcon,
      required NewsCategoryModel newscategory}) async {
    /// Form alanındaki verileri ile önce bir newscategory objesi oluşturulması
    NewsCategoryModel newBook = NewsCategoryModel(
        id: newscategory.id,
        categoryName: categoryName,
        categoryUrl: categoryUrl,
        categoryIcon: "a");

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setTabData(
        collectionPath: collectionPath, newscategoryAsMap: newBook.toMap());
  }
}
