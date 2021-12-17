import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/book_model.dart';
import 'package:newsappadminpanel/services/calculator.dart';
import 'package:newsappadminpanel/services/database.dart';

class UpdateBookViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'books';

  Future<void> updateBook(
      {required String bookName,
      required String authorName,
      required String publishDate,
      required Book book}) async {
    /// Form alanındaki verileri ile önce bir book objesi oluşturulması
    Book newBook = Book(
        id: book.id,
        bookName: bookName,
        authorName: authorName,
        publishDate: "a");

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setBookData(
        collectionPath: collectionPath, bookAsMap: newBook.toMap());
  }
}
