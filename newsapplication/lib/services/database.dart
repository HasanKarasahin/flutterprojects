import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getTabListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }
}
