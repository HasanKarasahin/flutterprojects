import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/tab_model.dart';
import 'package:newsappadminpanel/services/database.dart';

class BooksViewModel extends ChangeNotifier {
  /// bookview'ın state bilgisini tutmak
  /// bookview arayüzünün ihtiyacı olan metotları ve hesaplamalrı yapmak
  /// gerekli servislerle konuşmak
  String _collectionPath = 'Tabs';

  Database _database = Database();

  Stream<List<TabModel>> getBookList() {
    /// stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getBookListFromApi(_collectionPath)
        .map((querySnapshot) => querySnapshot.docs);

    ///Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<TabModel>> streamListBook =
        streamListDocument.map((listOfDocSnap) => listOfDocSnap
            .map((docSnap) => TabModel.fromMap({
                  "id": docSnap["id"],
                  "tabName": docSnap["tabName"],
                  "tabUrl": docSnap["tabUrl"],
                  "tabIcon": docSnap["tabIcon"],
                }))
            .toList());

    return streamListBook;
  }

  Future<void> deleteBook(TabModel book) async {
    await _database.deleteDocument(referecePath: _collectionPath, id: book.id);
  }
}
