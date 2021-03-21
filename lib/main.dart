import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EZ Tickets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
