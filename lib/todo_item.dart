import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem({Key? key, required this.todo, this.onToDoChanged, this.onDeleteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
        onTap: () {
          //print("cliked");
          onToDoChanged(todo);
          },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16, color: Colors.black,
            decoration: todo.isDone? TextDecoration.lineThrough : null
          ),
        ),
      trailing: Container(
        padding: EdgeInsets.all(0),
        // margin: EdgeInsets.symmetric(vertical: 12),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: IconButton(
          color: Colors.white,
          iconSize: 18,
          icon: Icon(Icons.clear),
          onPressed: () {
            // print("cliekd deleted");
            onDeleteItem(todo.id);
            },
        ),
      ),
      ),
    );
  }
}