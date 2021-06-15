import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.website});

  factory User.createData(Map<String, dynamic> object) {
    return User(
        id: object['id'],
        name: object['name'],
        username: object['username'],
        email: object['email'],
        phone: object['phone'],
        website: object['website']);
  }

  static Future<List<User>> getData() async {
    var urlApi = 'https://jsonplaceholder.typicode.com/users';

    var apiResult = await http.get(Uri.parse(urlApi));

    List<dynamic> data = json.decode(apiResult.body);
    List<User> listData = [];

    for (int i = 0; i < data.length; i++)
      listData.add(User.createData(data[i]));

    return listData;
  }
}
