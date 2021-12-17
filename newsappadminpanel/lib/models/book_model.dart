import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String bookName;
  final String authorName;
  final String publishDate;

  Book(
      {required this.id,
      required this.bookName,
      required this.authorName,
      required this.publishDate});

  /// objeden map oluşturan

  Map<String, dynamic> toMap() => {
        'id': id,
        'bookName': bookName,
        'authorName': authorName,
        'publishDate': publishDate
      };

  /// mapTen obje oluşturan yapıcı

  factory Book.fromMap(Map map) => Book(
      id: map['id'],
      bookName: map['bookName'],
      authorName: map['authorName'],
      publishDate: map['publishDate']);
}
