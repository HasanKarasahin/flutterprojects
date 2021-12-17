import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsappadminpanel/models/tab_model.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firestore servisinden kitapların verisini stream olarak alıp sağlamak

  Stream<QuerySnapshot> getBookListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  /// Firestore üzerindeki bir veriyi silme hizmeti
  Future<void> deleteDocument(
      {required String referecePath, required String id}) async {
    await _firestore.collection(referecePath).doc(id).delete();
  }

  /// firestore'a yeni veri ekleme ve güncelleme hizmeti
  Future<void> setBookData(
      {required String collectionPath,
      required Map<String, dynamic> bookAsMap}) async {
    await _firestore
        .collection(collectionPath)
        .doc(TabModel.fromMap(bookAsMap).id)
        .set(bookAsMap);
  }
}
