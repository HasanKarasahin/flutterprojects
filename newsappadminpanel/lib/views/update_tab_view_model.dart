import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/tab_model.dart';
import 'package:newsappadminpanel/services/calculator.dart';
import 'package:newsappadminpanel/services/database.dart';

class UpdateBookViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'Tabs';

  Future<void> updateBook(
      {required String tabName,
      required String tabUrl,
      required String tabIcon,
      required TabModel book}) async {
    /// Form alanındaki verileri ile önce bir book objesi oluşturulması
    TabModel newBook =
        TabModel(id: book.id, tabName: tabName, tabUrl: tabUrl, tabIcon: "a");

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setBookData(
        collectionPath: collectionPath, bookAsMap: newBook.toMap());
  }
}
