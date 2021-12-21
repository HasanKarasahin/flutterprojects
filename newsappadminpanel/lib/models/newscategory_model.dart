import 'package:cloud_firestore/cloud_firestore.dart';

class NewsCategoryModel {
  final String id;
  final String categoryName;
  final String categoryUrl;
  final String categoryIcon;

  NewsCategoryModel(
      {required this.id,
      required this.categoryName,
      required this.categoryUrl,
      required this.categoryIcon});

  /// objeden map oluşturan

  Map<String, dynamic> toMap() => {
        'id': id,
        'categoryName': categoryName,
        'categoryUrl': categoryUrl,
        'categoryIcon': categoryIcon
      };

  /// mapTen obje oluşturan yapıcı

  factory NewsCategoryModel.fromMap(Map map) => NewsCategoryModel(
      id: map['id'],
      categoryName: map['categoryName'],
      categoryUrl: map['categoryUrl'],
      categoryIcon: map['categoryIcon']);
}
