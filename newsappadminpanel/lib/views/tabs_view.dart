import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newsappadminpanel/models/tab_model.dart';
import 'package:newsappadminpanel/views/tabs_view_model.dart';
import 'package:newsappadminpanel/views/update_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'add_tab_view.dart';

class BooksView extends StatefulWidget {
  @override
  _BooksViewState createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BooksViewModel>(
      create: (_) => BooksViewModel(),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('Tab Listesi')),
        body: Center(
          child: Column(children: [
            StreamBuilder<List<TabModel>>(
              stream: Provider.of<BooksViewModel>(context, listen: false)
                  .getBookList(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  print(asyncSnapshot.error);
                  return const Center(
                      child:
                          Text('Bir Hata Oluştu, daha sonra tekrar deneyiniz'));
                } else {
                  if (!asyncSnapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    List<TabModel>? kitapList = asyncSnapshot.data;
                    if (kitapList != null) {
                      return BuildListView(
                        kitapList: kitapList,
                        key: Key("a"),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
                }
              },
            ),
            Divider(),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBookView()));
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}

class BuildListView extends StatefulWidget {
  const BuildListView({
    required Key key,
    required this.kitapList,
  }) : super(key: key);

  final List<TabModel> kitapList;

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  bool isFiltering = false;
  late List<TabModel> filteredList;

  @override
  Widget build(BuildContext context) {
    var fullList = widget.kitapList;
    return Flexible(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Arama: Kitap adı',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0))),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  isFiltering = true;

                  setState(() {
                    filteredList = fullList
                        .where((book) => book.tabName
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  });
                } else {
                  WidgetsBinding.instance!.focusManager.primaryFocus!.unfocus();
                  setState(() {
                    isFiltering = false;
                  });
                }
              },
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: isFiltering ? filteredList.length : fullList.length,
                itemBuilder: (context, index) {
                  var list = isFiltering ? filteredList : fullList;
                  return Slidable(
                    child: Card(
                      child: ListTile(
                        title: Text(list[index].tabName),
                        subtitle: Text(list[index].tabUrl),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateBookView(
                                        list[index],
                                        book: list[index],
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
