import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herewego/models/post_model.dart';
import 'package:herewego/services/pref_service.dart';
import 'package:herewego/services/rtdb_service.dart';
import 'package:herewego/services/stor_service.dart';
import 'package:image_picker/image_picker.dart';

class DetailPage extends StatefulWidget {

  static final String id = 'detail_page';

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var isLoading = false;
  File _image;
  final picker = ImagePicker();

  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  void _addPost() async{
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();

    if(firstname.isEmpty || content.isEmpty || date.isEmpty || lastname.isEmpty) return;
    if(_image == null) return;

    _apiUploadImage(firstname, content, lastname, date);
  }

  _apiUploadImage(String firstname, String content, String lastname, String date) {
    setState(() {
      isLoading = true;
    });
    StoreService.uploadImage(_image).then((imgUrl) => {
      _apiAddPost(firstname, lastname, content, date, imgUrl)
    });
  }

  _apiAddPost (String firstname, String lastname, String content, String date, String imgUrl) async{
    var id = await Pref.loadUserId();
    RTDBService.storePost(new Post(id, firstname, lastname, content, date, imgUrl)).then((value) => {
      _respAddPost()
    });
  }

  _respAddPost() {
    Navigator.of(context).pop({'data' : 'done'});
  }

  Future _getImage() async {
    final pikcedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pikcedFile != null) {
        _image = File(pikcedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text('Add Post'),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: _image != null ?
                        Image.file(_image, fit: BoxFit.cover,):
                        Image.asset('assets/images/ic_camera.png'),
                      ),
                    onTap: _getImage,
                  ),
                  SizedBox(height: 15,),
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
          isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : SizedBox.shrink()
        ],
      ),
    );
  }
}
