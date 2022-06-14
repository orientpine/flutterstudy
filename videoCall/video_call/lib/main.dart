// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:video_call/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      home: HomeScreen(),
    ),
  );
}
