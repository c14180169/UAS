import 'package:flutter/material.dart';
import 'package:uas/album.dart';

class HalAlbum extends StatefulWidget {
  const HalAlbum({Key? key}) : super(key: key);

  @override
  _HalAlbumState createState() => _HalAlbumState();
}

class _HalAlbumState extends State<HalAlbum> {
  List<Album> listAlbums = [];
  List<Album> listAlbumsByUser = [];

  void getListApi() {
    Album.getData().then((value) {
      listAlbums = value;
      setState(() {});
    });
  }

  void sortData(String _idPost) {
    for (int i = 0; i < listAlbums.length; i++) {
      if (listAlbums[i].userId.toString() == _idPost.toString() &&
          listAlbumsByUser.length < 10) {
        listAlbumsByUser.add(listAlbums[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final idUser = ModalRoute.of(context)?.settings.arguments;

    getListApi();
    sortData(idUser.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: listAlbumsByUser.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Text(listAlbumsByUser[index].title),
                          onTap: () {
                            Navigator.pushNamed(context, '/photos',
                                arguments: listAlbumsByUser[index].id);
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
