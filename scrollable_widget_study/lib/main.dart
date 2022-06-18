import 'package:flutter/material.dart';
import 'package:scrollable_widget_study/color/color_schemes.g.dart';
import 'package:scrollable_widget_study/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(colorScheme: lightColorScheme),
      home: Home_Screen(),
    ),
  );
}
