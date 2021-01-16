import 'package:flutter/material.dart';
import 'package:herewego/models/post_model.dart';
import 'package:herewego/services/pref_service.dart';
import 'package:herewego/services/rtdb_service.dart';

class DetailPage extends StatefulWidget {

  static final String id = 'detail_page';

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  void _addPost() async{
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();

    if(firstname.isEmpty || content.isEmpty || firstname.isEmpty || lastname.isEmpty) return;

    var id = await Pref.loadUserId();
    RTDBService.storePost(new Post(id, firstname, lastname, content, date)).then((value) => {
      _respAddPost()
    });
  }

  _respAddPost() {
    Navigator.of(context).pop({'data' : 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text('Add Post'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: firstnameController,
                decoration: InputDecoration(
                  hintText: 'Firstname'
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                    hintText: 'Lastname'
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                    hintText: 'Content'
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                    hintText: 'Date'
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 45,
                width: double.infinity,
                child: FlatButton(
                  child: Text('Add'),
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  onPressed: _addPost,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
