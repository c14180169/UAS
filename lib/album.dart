import 'package:http/http.dart' as http;
import 'dart:convert';

class Album {
  int id;
  int userId;
  String title;

  Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory Album.createData(Map<String, dynamic> object) {
    return Album(
      id: object['id'],
      userId: object['userId'],
      title: object['title'],
    );
  }

  static Future<List<Album>> getData() async {
    var urlApi = 'https://jsonplaceholder.typicode.com/albums';

    var apiResult = await http.get(Uri.parse(urlApi));

    List<dynamic> data = json.decode(apiResult.body);
    List<Album> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Album.createData(data[i]));

    return listData;
  }
}
