import 'package:firebase_database/firebase_database.dart';
import 'package:herewego/models/post_model.dart';

class RTDBService {
  static final _database = FirebaseDatabase.instance.reference();

  static Future<Stream<Event>> storePost(Post post) async {
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Post>> loadPosts(String id) async {
    List<Post> items = new List();
    Query _query = _database.reference().child("posts").orderByChild("userId").equalTo(id);
    var snapshot = await _query.once();
    var result = snapshot.value.values as Iterable;

    for(var item in result) {
      items.add(Post.fromJson(Map<String, dynamic>.from(item)));
    }
    return items;
  }
}