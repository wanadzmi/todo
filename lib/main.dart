import 'package:flutter/material.dart';
import 'package:todo/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData(
        // Declare primary color for the whole app
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      // Navigate to home page
      home: const HomePage(),
    );
  }
}
