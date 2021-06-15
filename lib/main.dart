import 'package:flutter/material.dart';
import 'package:uas/halPhoto.dart';
import 'halAlbum.dart';
import 'halComment.dart';
import 'user.dart';
import 'halPost.dart';
import 'halTodo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(),
        '/posts': (context) => HalPosts(),
        '/todo': (context) => HalTodo(),
        '/comments': (context) => HalComment(),
        '/albums': (context) => HalAlbum(),
        '/photos': (context) => HalPhoto(),
      },
      title: "App User",
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> listUsers = [];
  void getListApi() {
    User.getData().then((value) {
      listUsers = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    getListApi();

    return Scaffold(
      appBar: AppBar(
        title: Text("List Users"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: listUsers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(20),
                        leading: Icon(Icons.account_circle_rounded),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listUsers[index].name,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                Text(listUsers[index].email),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/albums',
                                          arguments: listUsers[index].id);
                                    },
                                    child: Text("ALBUMS")),
                                Padding(padding: EdgeInsets.all(5)),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/todo',
                                          arguments: listUsers[index].id);
                                    },
                                    child: Text("TO-DO LIST")),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/posts',
                              arguments: listUsers[index].id);
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
