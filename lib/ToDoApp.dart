import 'package:demo/Colors.dart';
import '../ToDoItems.dart';
import '../modules/todo.dart';
import 'package:flutter/material.dart';

class Todoapp extends StatefulWidget {
  Todoapp({super.key});

  @override
  State<Todoapp> createState() => _TodoappState();
}

class _TodoappState extends State<Todoapp> {
  final _todoController = TextEditingController();
  final todolist = Todo.todolist;
  List<Todo> _foundtodo = [];

  @override
  void initState() {
    _foundtodo = todolist; // Initially, show all tasks
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        title: const Text(
          "To Do App",
          selectionColor: Colors.white,
        ),
        backgroundColor: tPanel,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
          size: 30,
        ),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: Container(
        color: bg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: search(),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: const Text(
                        "All To-dos",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    for (Todo todo in _foundtodo)
                      Todoitems(
                        onToDoChange: _handleTodoChange,
                        todo: todo,
                        onDelete: _deleteItem,
                      ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            hintText: "Add a new task",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          addTask(_todoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPanel,
                          minimumSize: const Size(50, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        child: const Text(
                          "+",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteItem(String idd) {
    setState(() {
      todolist.removeWhere((item) => item.id == idd);
      _foundtodo = todolist; // Update the filtered list
    });
  }

  void addTask(String task) {
    setState(() {
      if (task.isNotEmpty) {
        todolist.add(
          Todo(
            id: DateTime.now().microsecond.toString(),
            toDoText: task,
          ),
        );
        _foundtodo = todolist; // Update the filtered list
      }
    });
    _todoController.clear();
  }

  void _runFilter(String key) {
    List<Todo> result = [];
    if (key.isEmpty) {
      result = todolist; // Show all tasks if the search query is empty
    } else {
      result = todolist
          .where((item) => item.toDoText!.toLowerCase().contains(key.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundtodo = result;
    });
  }


  Widget search() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tPanel, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          hintText: 'Search a Task',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 25,
          ),
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}
