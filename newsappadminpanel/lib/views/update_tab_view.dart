import 'package:flutter/material.dart';
import 'package:newsappadminpanel/models/tab_model.dart';
import 'package:newsappadminpanel/views/update_tab_view_model.dart';
import 'package:provider/provider.dart';

class UpdateBookView extends StatefulWidget {
  final TabModel book;

  const UpdateBookView(TabModel list, {required this.book});

  @override
  _UpdateBookViewState createState() => _UpdateBookViewState();
}

class _UpdateBookViewState extends State<UpdateBookView> {
  TextEditingController bookCtr = TextEditingController();
  TextEditingController authorCtr = TextEditingController();
  TextEditingController publishCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _selectedDate;

  @override
  void dispose() {
    bookCtr.dispose();
    authorCtr.dispose();
    publishCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bookCtr.text = widget.book.tabName;
    authorCtr.text = widget.book.tabUrl;
    publishCtr.text = "a";

    return ChangeNotifierProvider<UpdateBookViewModel>(
      create: (_) => UpdateBookViewModel(),
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
                    controller: bookCtr,
                    decoration: InputDecoration(
                        hintText: 'Kitap Adı', icon: Icon(Icons.book)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kitap Adı Boş Olamaz';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    controller: authorCtr,
                    decoration: InputDecoration(
                        hintText: 'Yazar Adı', icon: Icon(Icons.edit)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Yazar Adı Boş Olamaz';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Güncelle'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      /// kulanıcı bilgileri ile addNewBook metodu çağırılacak,
                      await context.read<UpdateBookViewModel>().updateBook(
                          tabName: bookCtr.text,
                          tabUrl: authorCtr.text,
                          tabIcon: "a",
                          book: widget.book);

                      /// navigator.pop
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
