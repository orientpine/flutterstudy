import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: Center(
          child: Text(
            'Hello, Worl333d!',
            style: TextStyle(
                color: Color.fromARGB(255, 124, 37, 37), fontSize: 50),
          ),
        ),
      ),
    ),
  );
}
