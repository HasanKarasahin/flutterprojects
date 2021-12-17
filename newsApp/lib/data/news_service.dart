import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsApp/models/article.dart';
import 'package:newsApp/models/news.dart';

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  static Future<List<Articles>> getNews(int index, String url) async {
    //String url = newsTypes.elementAt(index);

    final response = await http.get(url);

    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
