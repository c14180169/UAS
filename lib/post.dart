import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  int id;
  int userId;
  String title;
  String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.createData(Map<String, dynamic> object) {
    return Post(
      id: object['id'],
      userId: object['userId'],
      title: object['title'],
      body: object['body'],
    );
  }

  static Future<List<Post>> getData() async {
    var urlApi = 'https://jsonplaceholder.typicode.com/posts';

    var apiResult = await http.get(Uri.parse(urlApi));

    List<dynamic> data = json.decode(apiResult.body);
    List<Post> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Post.createData(data[i]));

    return listData;
  }
}
