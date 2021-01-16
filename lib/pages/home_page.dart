import 'package:flutter/material.dart';
import 'package:herewego/models/post_model.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/pref_service.dart';
import 'package:herewego/services/rtdb_service.dart';

class HomePage extends StatefulWidget {

  static final String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> items = new List();

  _apiLoadStore() async {
    var id = await Pref.loadUserId();
    RTDBService.loadPosts(id).then((posts) => {
      _respPost(posts)
    });
  }

  _respPost(List<Post> posts) {
    setState(() {
      items = posts;
    });
  }

  Future _openDetailPage() async {
    Map result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return new DetailPage();
      }
    ));

    if(result != null && result.containsKey('data')) {
      print(result['data']);
      _apiLoadStore();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiLoadStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Posts'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              AuthService.signOutUser(context);
              Navigator.pushReplacementNamed(context, SignInPage.id);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return _itemOfList(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
        onPressed: _openDetailPage,
      ),
    );
  }

  Widget _itemOfList(Post post) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.firstname + ' ' + post.lastname, style: TextStyle(color: Colors.black, fontSize: 20),),
          SizedBox(height: 5,),
          Text(post.date),
          SizedBox(height: 5,),
          Text(post.content, style: TextStyle(color: Colors.black, fontSize: 16))
        ],
      ),
    );
  }
}
