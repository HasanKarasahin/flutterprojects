import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsappadminpanel/models/newscategory_model.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getTabListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  Future<void> deleteDocument(
      {required String referecePath, required String id}) async {
    await _firestore.collection(referecePath).doc(id).delete();
  }

  Future<void> setTabData(
      {required String collectionPath,
      required Map<String, dynamic> newscategoryAsMap}) async {
    await _firestore
        .collection(collectionPath)
        .doc(NewsCategoryModel.fromMap(newscategoryAsMap).id)
        .set(newscategoryAsMap);
  }
}
