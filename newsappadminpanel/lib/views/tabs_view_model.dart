import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/tab_model.dart';
import 'package:newsappadminpanel/services/database.dart';

class TabViewModel extends ChangeNotifier {
  String _collectionPath = 'Tabs';

  Database _database = Database();

  Stream<List<TabModel>> getTabList() {
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getTabListFromApi(_collectionPath)
        .map((querySnapshot) => querySnapshot.docs);

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
