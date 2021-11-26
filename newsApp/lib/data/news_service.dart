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

  //https://newsapi.org/v2/everything?q=apple&from=2021-11-21&to=2021-11-21&sortBy=popularity&language=tr&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab
  //https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab
  //https://newsapi.org/v2/top-headlines?country=tr&category=sport&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab

  static List<String> newsTypes = [
    'https://newsapi.org/v2/everything?q=apple&from=2021-11-21&to=2021-11-21&sortBy=popularity&language=tr&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab',
    'https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab',
    'https://newsapi.org/v2/top-headlines?country=tr&category=sport&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab'
  ];

  static Future<List<Articles>> getNews(int index) async {
    String url = newsTypes.elementAt(index);

    final response = await http.get(url);

    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
