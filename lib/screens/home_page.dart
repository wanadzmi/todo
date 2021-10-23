import 'package:flutter/material.dart';
import '../db/todo_db.dart';
import '../models/todo_model.dart';
import '../widgets/todo_list.dart';
import 'insert_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // declare connection with DB
  var db = TodoDatabase();

  // Declare insert item function here to communicate with DB
  void insertItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  // Declare delete item function to here communicate with DB
  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),

      // Floating action to navigate to insert page
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                //
                builder: (context) => InsertPage(insertFunction: insertItem)),
          );
        },
      ),
      body: Column(
        children: [
          // Pass delete functions to the TodoList widget so that this functions can be use there.
          TodoList(
            deleteFunction: deleteItem,
          ),
        ],
      ),
    );
  }
}
