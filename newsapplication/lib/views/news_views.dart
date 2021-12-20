import 'package:flutter/material.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/models/tab_model.dart';
import 'package:newsapplication/services/news_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  late TabModel tabInfo;

  NewsView(this.tabInfo);

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<Articles> articles = [];

  @override
  void initState() {
    NewsService.getNews(widget.tabInfo).then((value) {
      setState(() {
        articles = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.tabInfo.tabName}"),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Image.network(articles[index].urlToImage ??
                          'https://i0.wp.com/designermenus.com.au/wp-content/uploads/2016/02/icon-None.png?w=300&ssl=1'),
                      ListTile(
                        leading: Icon(Icons.arrow_drop_down_circle),
                        title: Text(articles[index].title ?? ''),
                        subtitle: Text(articles[index].author ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(articles[index].description ?? ''),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          MaterialButton(
                              onPressed: () async {
                                await launch(articles[index].url ?? '');
                              },
                              child: Text('Habere Git')),
                        ],
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
