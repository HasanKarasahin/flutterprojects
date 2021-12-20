import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/models/news.dart';
import 'package:newsapplication/models/tab_model.dart';

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  static Future<List<Articles>?> getNews(TabModel tabInfo) async {
    String url = tabInfo.tabUrl;

    final response = await http.get(url);

    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
