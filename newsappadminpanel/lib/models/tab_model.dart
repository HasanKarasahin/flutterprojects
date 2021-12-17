import 'package:cloud_firestore/cloud_firestore.dart';

class TabModel {
  final String id;
  final String tabName;
  final String tabUrl;
  final String tabIcon;

  TabModel(
      {required this.id,
      required this.tabName,
      required this.tabUrl,
      required this.tabIcon});

  /// objeden map oluşturan

  Map<String, dynamic> toMap() =>
      {'id': id, 'tabName': tabName, 'tabUrl': tabUrl, 'tabIcon': tabIcon};

  /// mapTen obje oluşturan yapıcı

  factory TabModel.fromMap(Map map) => TabModel(
      id: map['id'],
      tabName: map['tabName'],
      tabUrl: map['tabUrl'],
      tabIcon: map['tabIcon']);
}
