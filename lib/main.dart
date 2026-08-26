import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //gives screen

        appBar: AppBar(
          backgroundColor: Colors.green,
          shadowColor: Colors.black,
          title: const Text("data"),
        ),

        body: Container(color: Colors.brown, height: 200, width: 200),
      ),
    );
  }
}
