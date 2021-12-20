import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsApp/data/news_service.dart';
import 'package:newsApp/models/article.dart';
import 'package:newsApp/models/tab_model.dart';
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

  void getTabData(tabIndex, state) async {
    CollectionReference tabsCollection = _firestore.collection("Tabs");
    var tabCollection = tabsCollection.doc("Tab1");
    var response = await tabCollection.get();
    dynamic data = response.data();

    TabModel model = new TabModel(
        id: tabIndex,
        tabName: data["tabName"],
        tabIcon: data["tabIcon"],
        tabUrl: data["tabUrl"]);

    tabsData.add(model);

    print(tabsData);

    if (state) {
      NewsService.getNews(0, tabsData.first.tabUrl).then((value) {
        setState(() {
          articles = value;
        });
      });
    }

/*
    for (int i = 0; i < 3; i++) {
      tabs[i] = data["Tab" + (i + 1).toString()];
    }*/
  }

  Future<void> getNewLink() async {
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
    getTabData(0, true);

    super.initState();
  }

  final _firestore = FirebaseFirestore.instance;

  List<String> tabs = ["a"];
  List<String> tabsUrl = ["", "", ""];

  List<TabModel> tabsData = [];

  List<BottomNavigationBarItem> bottomNavItems = [];
  List tabsTemp;

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      NewsService.getNews(_selectedIndex, tabsData.first.tabUrl).then((value) {
        setState(() {
          articles = value;
        });
      });
    });
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/tab_data.json');
    final data = await json.decode(response);
    setState(() {
      bottomNavItems.add(BottomNavigationBarItem(
          icon: Icon(Icons.explore), title: Text(data[0]["tabName"])));
      bottomNavItems.add(BottomNavigationBarItem(
          icon: Icon(Icons.explore), title: Text(data[1]["tabName"])));
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    TabModel model = new TabModel(
        id: "5",
        tabName: "TestTab",
        tabIcon: "TestIcon",
        tabUrl:
            "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab");

    tabsData.add(model);*/

    //getTabData(1, false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child: tabsData.isNotEmpty
              ? Text(tabsData.elementAt(0).id)
              : Text("data yok")),
    );
  }
}
