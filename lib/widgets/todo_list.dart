import 'package:flutter/material.dart';
import '../db/todo_db.dart';
import './todo_card.dart';

class TodoList extends StatefulWidget {
  final Function insertFunction;
  final Function deleteFunction;

  const TodoList({
    required this.insertFunction,
    required this.deleteFunction,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final db = TodoDatabase();
  @override
  Widget build(BuildContext context) {
    // Display list of Todos here
    return Expanded(
        child: FutureBuilder(
            // run get all list function
            future: db.getTodo(),
            initialData: const [],
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              var data = snapshot.data;
              var datalength = data!.length;
              return datalength == 0
                  // Show this when data empty
                  ? const Center(
                      child: Text("It's Empty"),
                    )
                  // Build the listview
                  : ListView.builder(
                      itemCount: datalength,
                      itemBuilder: (context, i) => TodoCard(
                          id: data[i].id,
                          title: data[i].title,
                          startDate: data[i].startDate,
                          endDate: data[i].endDate,
                          creationDate: data[i].creationDate,
                          isChecked: data[i].isChecked,
                          insertFunction: widget.insertFunction,
                          deleteFunction: widget.deleteFunction));
            }));
  }
}
