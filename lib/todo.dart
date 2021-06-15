import 'package:http/http.dart' as http;
import 'dart:convert';

class Todo {
  int id;
  int userId;
  String title;
  bool completed;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory Todo.createData(Map<String, dynamic> object) {
    return Todo(
      id: object['id'],
      userId: object['userId'],
      title: object['title'],
      completed: object['completed'],
    );
  }

  static Future<List<Todo>> getData() async {
    var urlApi = 'https://jsonplaceholder.typicode.com/todos';

    var apiResult = await http.get(Uri.parse(urlApi));

    List<dynamic> data = json.decode(apiResult.body);
    List<Todo> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Todo.createData(data[i]));

    return listData;
  }
}
