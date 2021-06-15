import 'package:flutter/material.dart';
import 'package:uas/comment.dart';

class HalComment extends StatefulWidget {
  const HalComment({Key? key}) : super(key: key);

  @override
  _HalCommentState createState() => _HalCommentState();
}

class _HalCommentState extends State<HalComment> {
  List<Comment> listComments = [];
  List<Comment> listCommentsByUser = [];

  void getListApi() {
    Comment.getData().then((value) {
      listComments = value;
      setState(() {});
    });
  }

  void sortData(String _idPost) {
    for (int i = 0; i < listComments.length; i++) {
      if (listComments[i].postId.toString() == _idPost.toString() &&
          listCommentsByUser.length < 5) {
        listCommentsByUser.add(listComments[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final idPost = ModalRoute.of(context)?.settings.arguments;

    getListApi();
    sortData(idPost.toString());
    print(listCommentsByUser.length);

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: listCommentsByUser.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Text(listCommentsByUser[index].name),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.all(10)),
                              Text(
                                listCommentsByUser[index].email,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(listCommentsByUser[index].body),
                            ],
                          ),
                          onTap: () {},
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
