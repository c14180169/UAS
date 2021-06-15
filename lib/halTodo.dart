import 'package:flutter/material.dart';
import 'package:uas/todo.dart';

class HalTodo extends StatefulWidget {
  const HalTodo({Key? key}) : super(key: key);

  @override
  _HalTodoState createState() => _HalTodoState();
}

class _HalTodoState extends State<HalTodo> {
  List<Todo> listTodo = [];
  List<Todo> listTodoByUser = [];

  void getListApi() {
    Todo.getData().then((value) {
      listTodo = value;
      setState(() {});
    });
  }

  void sortData(String _idUser) {
    for (int i = 0; i < listTodo.length; i++) {
      if (listTodo[i].userId.toString() == _idUser.toString() &&
          listTodoByUser.length < 20) {
        listTodoByUser.add(listTodo[i]);
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
        title: Text("To-dos"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: listTodoByUser.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Text(listTodoByUser[index].title),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.all(10)),
                              Text('Completed : ' +
                                  listTodoByUser[index].completed.toString())
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
