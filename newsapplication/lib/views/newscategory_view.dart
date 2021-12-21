import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newsapplication/models/newscategory_model.dart';
import 'package:newsapplication/views/newscategory_view_model.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

import 'news_views.dart';

class NewsCategoryView extends StatefulWidget {
  @override
  _NewsCategoryViewState createState() => _NewsCategoryViewState();
}

class _NewsCategoryViewState extends State<NewsCategoryView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsCategoryViewModel>(
      create: (_) => NewsCategoryViewModel(),
      builder: (context, child) => Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(title: Text('Haber Kategorileri')),
          body: Center(
            child: Column(children: [
              StreamBuilder<List<NewsCategoryModel>>(
                stream:
                    Provider.of<NewsCategoryViewModel>(context, listen: false)
                        .getCategoryList(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return const Center(
                        child: Text(
                            'Bir Hata Oluştu, daha sonra tekrar deneyiniz'));
                  } else {
                    if (!asyncSnapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      List<NewsCategoryModel>? listNewsCategoryModel =
                          asyncSnapshot.data;
                      if (listNewsCategoryModel != null) {
                        return BuildListView(
                          listNewsCategoryModel: listNewsCategoryModel,
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
    required this.listNewsCategoryModel,
  }) : super(key: key);

  final List<NewsCategoryModel> listNewsCategoryModel;

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  @override
  Widget build(BuildContext context) {
    var fullList = widget.listNewsCategoryModel;
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
                        title: Text(list[index].categoryName),
                        subtitle: Text(""),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsView(list[index])));
                        },
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
