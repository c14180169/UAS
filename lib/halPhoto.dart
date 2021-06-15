import 'package:flutter/material.dart';
import 'package:uas/photo.dart';

class HalPhoto extends StatefulWidget {
  const HalPhoto({Key? key}) : super(key: key);

  @override
  _HalPhotoState createState() => _HalPhotoState();
}

class _HalPhotoState extends State<HalPhoto> {
  List<Photo> listPhotos = [];
  List<Photo> listPhotosByUser = [];

  void getListApi() {
    Photo.getData().then((value) {
      listPhotos = value;
      setState(() {});
    });
  }

  void sortData(String _idPost) {
    for (int i = 0; i < listPhotos.length; i++) {
      if (listPhotos[i].albumId.toString() == _idPost.toString() &&
          listPhotosByUser.length < 50) {
        listPhotosByUser.add(listPhotos[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final idAlbum = ModalRoute.of(context)?.settings.arguments;

    getListApi();
    sortData(idAlbum.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: listPhotosByUser.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listPhotosByUser[index].title,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(padding: EdgeInsets.all(20)),
                              Image.network(
                                  listPhotosByUser[index].url.toString())
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
