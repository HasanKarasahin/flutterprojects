import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/newscategory_model.dart';
import 'package:newsappadminpanel/views/add_newscategory_view_model.dart';
import 'package:newsappadminpanel/views/update_newscategory_view_model.dart';
import 'package:provider/provider.dart';

class AddNewsCategoryView extends StatefulWidget {
  @override
  _AddNewsCategoryViewState createState() => _AddNewsCategoryViewState();
}

class _AddNewsCategoryViewState extends State<AddNewsCategoryView> {
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
    return ChangeNotifierProvider<AddNewsCategoryViewModel>(
      create: (_) => AddNewsCategoryViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: Text('Haber Kategorisi Ekle')),
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
                  child: Text('Ekle'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await context
                          .read<AddNewsCategoryViewModel>()
                          .addNewsCategory(
                              categoryName: newscategoryCtr.text,
                              categoryUrl: authorCtr.text,
                              categoryIcon: "a");
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
