import 'package:demo/modules/todo.dart';
import 'package:flutter/material.dart';

class Todoitems extends StatelessWidget {
  final onDelete;
  
  final onToDoChange;
  
  final Todo todo;

 const Todoitems({
    super.key,
    required this.todo,
    required this.onToDoChange,
    this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      child: ListTile(
        
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        onTap: () {
          onToDoChange(todo);
          // Print or handle the to-do item click event
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        
        leading: Icon(
          todo.isDone? Icons.check_box: Icons.check_box_outline_blank  ,
          color: Colors.blue,
        ),
        title: Text(
          todo.toDoText ?? '',  // Providing a default empty string if null
          style: TextStyle(
            decoration: todo.isDone?  TextDecoration.lineThrough: TextDecoration.none,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            onDelete(todo.id);
            
            // Handle the delete action here
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
