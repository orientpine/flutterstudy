import 'package:flutter/material.dart';
import 'package:navigation_study/screen/home_screen.dart';
import 'package:navigation_study/screen/route_one_screen.dart';
import 'package:navigation_study/screen/route_three_screen.dart';
import 'package:navigation_study/screen/route_two_screen.dart';

void main() {
  runApp(MaterialApp(
    // debugShowCheckedModeBanner: false,
    // home: HomeScreen(),
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => HomeScreen(),
      '/one': (BuildContext context) => RouteOneScreen(),
      '/two': (BuildContext context) => RouteTwoScreen(),
      '/three': (BuildContext context) => RouteThreeScreen(),
    },
  ));
}
