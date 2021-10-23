import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo_model.dart';

class InsertTitleValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'Title can\'t be empty' : null;
  }
}

class InsertStartDateValidator {
  static String? validate(DateTime? value) {
    return value == null ? 'Start Date can\'t be empty' : null;
  }
}

class InsertEndDateValidator {
  static String? validate(DateTime? value) {
    return value == null ? 'End Date can\'t be empty' : null;
  }
}

class InsertPage extends StatefulWidget {
  // To receive & use insert function
  final Function insertFunction;
  const InsertPage({required this.insertFunction, Key? key}) : super(key: key);

  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  // Use to validate form
  final _formKey = GlobalKey<FormState>();

  // Text editing controller to receive and send data input by user
  final titleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final format = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Colors.black, size: 16),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add New To-Do List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
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
                  TextFormField(
                    maxLines: 10,
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Please key in your To-Do title here',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.black38),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    validator: (value) => InsertTitleValidator.validate(value!),
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
                    validator: (value) =>
                        InsertStartDateValidator.validate(value),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: currentValue ??
                              // Disable expired date so that user only be able to select current or future date only.
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
                    validator: (value) =>
                        InsertEndDateValidator.validate(value),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  // Validation form. check all form filled.
                  if (_formKey.currentState!.validate()) {
                    var myTodo = Todo(
                      title: titleController.text,
                      startDate: DateTime.parse(startDateController.text),
                      endDate: DateTime.parse(endDateController.text),
                      creationDate: DateTime.now(),
                      isChecked: false,
                    );

                    // Insert data function when tap
                    widget.insertFunction(myTodo);

                    // Redirect back to home page after data successfully inserted.
                    Navigator.pop(context, true);
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
                    'Create Now',
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
