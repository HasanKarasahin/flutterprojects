import 'package:newsappadminpanel/models/tab_model.dart';
import 'package:newsappadminpanel/services/calculator.dart';
import 'package:newsappadminpanel/services/database.dart';
import 'package:flutter/material.dart';

class AddBookViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'Tabs';

  Future<void> addNewBook(
      {required String tabName,
      required String tabUrl,
      required String tabIcon}) async {
    /// Form alanındaki verileri ile önce bir book objesi oluşturulması
    TabModel newBook = TabModel(
        id: DateTime.now().toIso8601String(),
        tabName: tabName,
        tabUrl: tabUrl,
        tabIcon: tabIcon);

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setBookData(
        collectionPath: collectionPath, bookAsMap: newBook.toMap());
  }
}
