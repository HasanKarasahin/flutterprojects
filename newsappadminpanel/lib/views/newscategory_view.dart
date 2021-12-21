import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newsappadminpanel/models/newscategory_model.dart';
import 'package:newsappadminpanel/views/newscategory_view_model.dart';
import 'package:newsappadminpanel/views/update_newscategory_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'add_newscategory_view.dart';

class NewsCategoryView extends StatefulWidget {
  @override
  _NewsCategoryViewState createState() => _NewsCategoryViewState();
}

class _NewsCategoryViewState extends State<NewsCategoryView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryViewModel>(
      create: (_) => CategoryViewModel(),
      builder: (context, child) => Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(title: Text('Admin Paneli - Category Listesi')),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewsCategoryView()));
            },
            child: Icon(Icons.add),
          ),
          body: Center(
            child: Column(children: [
              StreamBuilder<List<NewsCategoryModel>>(
                stream: Provider.of<CategoryViewModel>(context, listen: false)
                    .getCategoryList(),
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
                      List<NewsCategoryModel>? categoryList =
                          asyncSnapshot.data;
                      if (categoryList != null) {
                        return BuildListView(
                          categoryList: categoryList,
                          key: Key("a"),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }
                  }
                },
              ),
              Divider()
            ]),
          )),
    );
  }
}

class BuildListView extends StatefulWidget {
  const BuildListView({
    required Key key,
    required this.categoryList,
  }) : super(key: key);

  final List<NewsCategoryModel> categoryList;

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  @override
  Widget build(BuildContext context) {
    var fullList = widget.categoryList;
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
                        subtitle: Text(list[index].categoryUrl),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateNewsCategoryView(
                                        list[index],
                                        newscategory: list[index],
                                      )));
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
