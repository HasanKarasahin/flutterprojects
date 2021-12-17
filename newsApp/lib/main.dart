import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsApp/data/news_service.dart';
import 'package:newsApp/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: unused_import
import 'dart:ui' as ui;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Haberler2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> articles = [];

  void getTabName() async {
    CollectionReference moviesRef = _firestore.collection("Settings");
    var BottomNavBarNamesRef = moviesRef.doc("BottomNavBarNames");
    var response = await BottomNavBarNamesRef.get();
    dynamic data = response.data();

    for (int i = 0; i < 3; i++) {
      tabs[i] = data["Tab" + (i + 1).toString()];
    }
  }

  void getNewLink() async {
    CollectionReference moviesRef = _firestore.collection("Settings");
    var BottomNavBarNamesRef = moviesRef.doc("NewsLink");
    var response = await BottomNavBarNamesRef.get();
    dynamic data = response.data();

    for (int i = 0; i < 3; i++) {
      tabsUrl[i] = data["Tab" + (i + 1).toString()];
    }
  }

  @override
  void initState() {
    NewsService.getNews(0, tabsUrl[0]).then((value) {
      setState(() {
        articles = value;
      });
    });
    super.initState();
  }

  final _firestore = FirebaseFirestore.instance;

  List<String> tabs = ["", "", ""];
  List<String> tabsUrl = ["", "", ""];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      NewsService.getNews(_selectedIndex, tabsUrl[_selectedIndex])
          .then((value) {
        setState(() {
          articles = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getTabName();
    AsyncSnapshot.waiting();
    getNewLink();
    AsyncSnapshot.waiting();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: tabs[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: tabs[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: tabs[2],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
