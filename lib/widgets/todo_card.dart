import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/todo_db.dart';
import 'package:todo/screens/update_page.dart';
import '../models/todo_model.dart';

// ignore: must_be_immutable
class TodoCard extends StatefulWidget {
  // Declare all field to be able to fetch and send data to another page
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime creationDate;
  bool isChecked;
  final Function insertFunction;
  final Function deleteFunction;

  TodoCard(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.creationDate,
      required this.isChecked,
      required this.insertFunction,
      required this.deleteFunction,
      Key? key})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final db = TodoDatabase();

  // Declare update item function that communicate with DB
  void updateItem(Todo todo) async {
    await db.updateTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Declare all data here to be able to process the data
    var passTodo = Todo(
      id: widget.id,
      title: widget.title,
      startDate: widget.startDate,
      endDate: widget.endDate,
      creationDate: widget.creationDate,
      isChecked: widget.isChecked,
    );

    // Calculate difference between Date End and Date Now
    var dateNow = DateTime.now();
    var estEndDate = widget.endDate;
    var diff = estEndDate.difference(dateNow);

    // Format the date time into XXX hrs XX min
    String sDuration =
        "${diff.inHours} hrs ${diff.inMinutes.remainder(60)} min";

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          // Slide left on the list to show options such as Delete & Update function
          IconSlideAction(
            caption: 'Update',
            color: Colors.indigo,
            icon: Icons.edit,

            // Update function can be run here
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdatePage(
                        todo: passTodo, updateFunction: updateItem))),
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,

            // Delete function can be run here
            onTap: () => {widget.deleteFunction(passTodo)},
          ),
        ],
        actionExtentRatio: 0.25,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () {
                          // Also another update function can be run here
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdatePage(
                                      todo: passTodo,
                                      updateFunction: updateItem)));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Start Date',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF8F8F8F),
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // Format start date time to passable format
                                    Text(
                                      DateFormat('dd MMM yyyy')
                                          .format(widget.startDate),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'End Date',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF8F8F8F),
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // Format end date time to passable format
                                    Text(
                                      DateFormat('dd MMM yyyy')
                                          .format(widget.endDate),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Time left',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF8F8F8F),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      sDuration,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFe7e3cf),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                              ),
                              height: 40,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Status  ',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF8F8F8F),
                                          ),
                                        ),

                                        // Detect isCheck true or false and display the status
                                        widget.isChecked == true
                                            ? const Text(
                                                'Completed',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : const Text(
                                                'Incomplete',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Tick if completed   ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 14,
                                          height: 14,
                                          color: Colors.white,

                                          // Detect isCheck true or false and display/undisplay the tick
                                          child: Checkbox(
                                            value: widget.isChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                widget.isChecked = value!;
                                              });
                                              passTodo.isChecked = value!;
                                              widget.insertFunction(passTodo);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
