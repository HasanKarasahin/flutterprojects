import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/newscategory_model.dart';
import 'package:newsappadminpanel/views/update_newscategory_view_model.dart';
import 'package:provider/provider.dart';

class UpdateNewsCategoryView extends StatefulWidget {
  final NewsCategoryModel newscategory;

  const UpdateNewsCategoryView(NewsCategoryModel list,
      {required this.newscategory});

  @override
  _UpdateNewsCategoryViewState createState() => _UpdateNewsCategoryViewState();
}

class _UpdateNewsCategoryViewState extends State<UpdateNewsCategoryView> {
  TextEditingController newscategoryCtr = TextEditingController();
  TextEditingController authorCtr = TextEditingController();
  TextEditingController publishCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _selectedDate;

  @override
  void dispose() {
    newscategoryCtr.dispose();
    authorCtr.dispose();
    publishCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    newscategoryCtr.text = widget.newscategory.categoryName;
    authorCtr.text = widget.newscategory.categoryUrl;
    publishCtr.text = "a";

    return ChangeNotifierProvider<UpdateNewsCategoryViewModel>(
      create: (_) => UpdateNewsCategoryViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: Text('Tab Bilgisini Güncelle')),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                    controller: newscategoryCtr,
                    decoration: InputDecoration(
                        hintText: 'Kategori Adı', icon: Icon(Icons.book)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kategori Adı Boş Olamaz';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    controller: authorCtr,
                    decoration: InputDecoration(
                        hintText: 'Url', icon: Icon(Icons.link)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Url Boş Olamaz';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Güncelle'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await context
                          .read<UpdateNewsCategoryViewModel>()
                          .updateNewsCategory(
                              categoryName: newscategoryCtr.text,
                              categoryUrl: authorCtr.text,
                              categoryIcon: "a",
                              newscategory: widget.newscategory);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
