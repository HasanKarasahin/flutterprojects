import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newsapplication/models/tab_model.dart';
import 'package:newsapplication/views/tabs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class BooksView extends StatefulWidget {
  @override
  _BooksViewState createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabViewModel>(
      create: (_) => TabViewModel(),
      builder: (context, child) => Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(title: Text('Haber Kategorileri')),
          body: Center(
            child: Column(children: [
              StreamBuilder<List<TabModel>>(
                stream: Provider.of<TabViewModel>(context, listen: false)
                    .getTabList(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    print(asyncSnapshot.error);
                    return const Center(
                        child: Text(
                            'Bir Hata Oluştu, daha sonra tekrar deneyiniz'));
                  } else {
                    if (!asyncSnapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      List<TabModel>? tabList = asyncSnapshot.data;
                      if (tabList != null) {
                        return BuildListView(
                          tabList: tabList,
                          key: Key("a"),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }
                  }
                },
              )
            ]),
          )),
    );
  }
}

class BuildListView extends StatefulWidget {
  const BuildListView({
    required Key key,
    required this.tabList,
  }) : super(key: key);

  final List<TabModel> tabList;

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  @override
  Widget build(BuildContext context) {
    var fullList = widget.tabList;
    return Flexible(
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: fullList.length,
                itemBuilder: (context, index) {
                  var list = fullList;
                  return Slidable(
                    child: Card(
                      child: ListTile(
                        title: Text(list[index].tabName),
                        subtitle: Text(list[index].tabUrl),
                        onTap: () {
                          /*
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateBookView(
                                        list[index],
                                        book: list[index],
                                      )));*/
                        },
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
