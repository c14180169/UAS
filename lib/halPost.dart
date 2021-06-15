import 'package:flutter/material.dart';
import 'package:uas/post.dart';

class HalPosts extends StatefulWidget {
  const HalPosts({Key? key}) : super(key: key);

  @override
  _HalPostsState createState() => _HalPostsState();
}

class _HalPostsState extends State<HalPosts> {
  List<Post> listPosts = [];
  List<Post> listPostsByUser = [];

  void getListApi() {
    Post.getData().then((value) {
      listPosts = value;
      //print(listPosts.length);
      setState(() {});
    });
  }

  void sortData(String _idUser) {
    for (int i = 0; i < listPosts.length; i++) {
      if (listPosts[i].userId.toString() == _idUser.toString() &&
          listPostsByUser.length < 10) {
        listPostsByUser.add(listPosts[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final idUser = ModalRoute.of(context)?.settings.arguments;

    getListApi();
    sortData(idUser.toString());
    print(listPostsByUser.length);

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: listPostsByUser.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Text(listPostsByUser[index].title),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.all(10)),
                              Text(listPostsByUser[index].body),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/comments',
                                arguments: listPostsByUser[index].id);
                          },
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
