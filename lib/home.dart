import 'package:flutter/material.dart';
import 'package:to_do_app_practice/model/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> _foundToDos = [];
  final todos = ToDo.todoList();
  final _toDoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundToDos = todos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      git statusappBar: _appBar(),
      backgroundColor: const Color.fromRGBO(76, 175, 80, 1),
      body: Stack(children: [
        Container(
            padding: EdgeInsets.only(bottom: 50),
            child: Column(children: [
              Container(
                child: _searchBox(),
              ),
              Expanded(
                  child: ListView(children: [
                for (ToDo toDo in _foundToDos.reversed)
                  ListTile(
                    onTap: () {
                      _handleToDoChange(toDo);
                    },
                    title: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        toDo.toDoText,
                        style: TextStyle(
                            fontSize: 30,
                            decoration: toDo.isDone
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                    ),
                    leading: Checkbox(
                      value: toDo.isDone,
                      onChanged: (value) {
                        _handleToDoChange(toDo);
                      },
                    ),
                    trailing: Container(
                      color: Colors.yellow,
                      padding: EdgeInsets.only(left: 0),
                      child: IconButton(
                          onPressed: () {
                            _deleteItem(toDo.id);
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  )
              ]))
            ])),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.all(5),
                            child: TextField(
                              controller: _toDoController,
                              decoration: InputDecoration(
                                  hintText: 'Add new To do item',
                                  filled: true,
                                  fillColor: Colors.yellowAccent,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ))),
                    FloatingActionButton(
                      onPressed: () {
                        _addToDos(_toDoController.text);
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Colors.yellowAccent,
                    )
                  ],
                )))
      ]),
    );
  }

  Widget _searchBox() {
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: "Search",
            filled: true,
            fillColor: Colors.yellowAccent),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: const Text(
          'To do List',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        elevation: 2,
        backgroundColor: Colors.yellow,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Image.asset('assets/images/wolf.jpeg'),
              ))
        ]);
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todos;
    } else {
      results = todos
          .where((item) => item.toDoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDos = results;
    });
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteItem(String iden) {
    setState(() {
      todos.removeWhere((test) => test.id == iden);
    });
  }

  void _addToDos(String newToDo) {
    setState(() {
      final trimmedToDo = newToDo.trim();
      if (trimmedToDo.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid task'),
          ),
        );
        return;
      }
      todos.add(ToDo(
          id: DateTime.fromMillisecondsSinceEpoch.toString(),
          toDoText: newToDo));
    });
    _toDoController.clear();
  }
}
