import 'package:http/http.dart' as http;
import 'dart:convert';

class Photo {
  int id;
  int albumId;
  String title;
  String url;
  String thumbnail;

  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnail,
  });

  factory Photo.createData(Map<String, dynamic> object) {
    return Photo(
      id: object['id'],
      albumId: object['albumId'],
      title: object['title'],
      url: object['url'],
      thumbnail: object['thumbnailUrl'],
    );
  }

  static Future<List<Photo>> getData() async {
    var urlApi = 'https://jsonplaceholder.typicode.com/photos';

    var apiResult = await http.get(Uri.parse(urlApi));

    List<dynamic> data = json.decode(apiResult.body);
    List<Photo> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(Photo.createData(data[i]));

    return listData;
  }
}
