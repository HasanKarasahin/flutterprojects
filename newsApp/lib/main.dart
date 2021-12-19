import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsApp/data/news_service.dart';
import 'package:newsApp/models/article.dart';
import 'package:newsApp/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: unused_import
import 'dart:ui' as ui;

import 'models/tab_model.dart';

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
      home: GetUserName("2021-12-18T02:14:34.992103"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Tabs');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot);
          return Text("Hata");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['tabName']} ${data['tabUrl']}");
        }

        return Text("loading");
      },
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> articles = [];

  void getTabName() async {
    CollectionReference moviesRef = _firestore.collection("Tabs");

    // int countDoc = await moviesRef.snapshots().map((event) => null);

    var BottomNavBarNamesRef = moviesRef.doc("BottomNavBarNames");
    var response = await BottomNavBarNamesRef.get();
    dynamic data = response.data();
/*
    for (int i = 0; i < 2; i++) {
      tabs[i] = data[data.id];
    }*/
  }

  Stream<List<TabModel>> getTabList() {
    CollectionReference moviesRef = _firestore.collection("Tabs");

    Stream<List<DocumentSnapshot>> streamListDocument =
        moviesRef.snapshots().map((querySnapshot) => querySnapshot.docs);

    ///Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<TabModel>> streamListBook =
        streamListDocument.map((listOfDocSnap) => listOfDocSnap
            .map((docSnap) => TabModel.fromMap({
                  "id": docSnap["id"],
                  "tabName": docSnap["tabName"],
                  "tabUrl": docSnap["tabUrl"],
                  "tabIcon": docSnap["tabIcon"],
                  tabs[0]: "a"
                }))
            .toList());

    streamListBook.map((event) => {tabs[0]: "Deniz"});

    tabs[1] = "Sadettin";
    return streamListBook;
  }

  void getNewLink() async {
    CollectionReference moviesRef = _firestore.collection("Settings");

    String t = await moviesRef.get().then((value) => value.docs.first.id);
    print(t);

/*
    var BottomNavBarNamesRef = moviesRef.doc("NewsLink");
    var response = await BottomNavBarNamesRef.get();
    dynamic data = response.data();

    for (int i = 0; i < 3; i++) {
      tabsUrl[i] = "a";
    }*/
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

  List<String> tabs = ["Hasolila", "Hasolila", "Hasolila"];
  List<String> tabsUrl = [
    "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab",
    "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab",
    "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=c17bc6c4ce594f04ab13d6937d5dfcab"
  ];

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
    //getNewLink();
    //getTabList();
    //AsyncSnapshot.waiting();
    //getNewLink();
    //AsyncSnapshot.waiting();

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
