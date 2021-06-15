import 'package:http/http.dart' as http;
import 'dart:convert';

class Comment {
  int id;
  int postId;
  String name;
  String email;
  String body;

  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.createData(Map<String, dynamic> object) {
    return Comment(
      id: object['id'],
      postId: object['postId'],
      name: object['name'],
      email: object['email'],
      body: object['body'],
    );
  }

  static Future<List<Comment>> getData() async {
    var urlApi = 'https://jsonplaceholder.typicode.com/comments';

    var apiResult = await http.get(Uri.parse(urlApi));

    List<dynamic> data = json.decode(apiResult.body);
    List<Comment> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Comment.createData(data[i]));

    return listData;
  }
}
