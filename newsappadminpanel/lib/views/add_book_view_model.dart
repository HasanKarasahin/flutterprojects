import 'package:newsappadminpanel/models/book_model.dart';
import 'package:newsappadminpanel/services/calculator.dart';
import 'package:newsappadminpanel/services/database.dart';
import 'package:flutter/material.dart';

class AddBookViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'Settings';

  Future<void> addNewBook(
      {required String bookName,
      required String authorName,
      required String publishDate}) async {
    /// Form alanındaki verileri ile önce bir book objesi oluşturulması
    Book newBook = Book(
        id: DateTime.now().toIso8601String(),
        bookName: bookName,
        authorName: authorName,
        publishDate: "a");

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setBookData(
        collectionPath: collectionPath, bookAsMap: newBook.toMap());
  }
}
