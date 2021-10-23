import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/db/todo_db.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/screens/home_page.dart';

class UpdateTitleValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'Title can\'t be empty' : null;
  }
}

class UpdatePage extends StatefulWidget {
  final Function updateFunction;
  final Todo? todo;
  const UpdatePage({
    this.todo,
    required this.updateFunction,
    Key? key,
  }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  // Declare form key to validate form.
  final _formKey = GlobalKey<FormState>();

  // To be able to retrieve data into form field. Cannot be null.
  TextEditingController? titleController;
  TextEditingController? startDateController;
  TextEditingController? endDateController;

  // Declare connection with database.
  final db = TodoDatabase();
  bool isLoading = false;

  // Date format to pass data.
  final format = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    // Retrieve back title, start date and end date datas from home screen.
    titleController = TextEditingController(text: widget.todo!.title);
    startDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.todo!.startDate));
    endDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.todo!.endDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 16,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Update To-Do List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ListView(
                children: [
                  const Text(
                    'To-Do Title',
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  const SizedBox(height: 10),
                  // Big size text area
                  TextFormField(
                    maxLines: 10,
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Please key in your To-Do title here',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black38),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    validator: (value) => UpdateTitleValidator.validate(value!),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Start Date',
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  const SizedBox(height: 10),
                  DateTimeField(
                    controller: startDateController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                      hintText: 'Select a date',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black38),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: currentValue ??
                              DateTime.now().subtract(const Duration(days: 0)),
                          lastDate: DateTime(2100));
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Estimate End Date',
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  const SizedBox(height: 10),
                  DateTimeField(
                    controller: endDateController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                      hintText: 'Select a date',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black38),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: currentValue ??
                              DateTime.now().subtract(const Duration(days: 0)),
                          lastDate: DateTime(2100));
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    var myTodo = Todo(
                      id: widget.todo!.id,
                      title: titleController!.text,
                      startDate: DateTime.parse(startDateController!.text),
                      endDate: DateTime.parse(endDateController!.text),
                      creationDate: widget.todo!.creationDate,
                      isChecked: widget.todo!.isChecked,
                    );
                    widget.updateFunction(myTodo);

                    // Navigate back to home page after successfully updated the data.
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: const HomePage(),
                        ),
                        (Route<dynamic> route) => false);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: const Text(
                    'Update',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
