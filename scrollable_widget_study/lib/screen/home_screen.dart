// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:scrollable_widget_study/layout/main_layout.dart';
import 'package:scrollable_widget_study/screen/custom_scroll_view_screen.dart';
import 'package:scrollable_widget_study/screen/grid_view_screen.dart';
import 'package:scrollable_widget_study/screen/list_view_screen.dart';
import 'package:scrollable_widget_study/screen/refresh_indicator_screen.dart';
import 'package:scrollable_widget_study/screen/reorderable_list_view_scren.dart';
import 'package:scrollable_widget_study/screen/scrollbar_screen.dart';
import 'package:scrollable_widget_study/screen/single_child_scroll_view_screen.dart';

class ScreenModel {
  final WidgetBuilder builder;
  final String name;
  ScreenModel({
    required this.builder,
    required this.name,
  });
}

class Home_Screen extends StatefulWidget {
  Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final screens = [
    ScreenModel(
        builder: (BuildContext context) => SingleChildScrollViewScreen(),
        name: 'SingleChildScrollViewScreen'),
    ScreenModel(
        builder: (BuildContext context) => ListViewScreen(),
        name: 'ListViewScreen'),
    ScreenModel(
        builder: (BuildContext context) => GridViewScreen(),
        name: 'GridViewScreen'),
    ScreenModel(
        builder: (BuildContext context) => ReOrderableListViewScreen(),
        name: 'ReOrderableViewScreen'),
    ScreenModel(
        builder: (BuildContext context) => CustomScrollViewScreen(),
        name: 'CustomScrollViewScreen'),
    ScreenModel(
      builder: (BuildContext context) => ScollbarScreen(),
      name: 'ScrollScreen',
    ),
    ScreenModel(
        builder: (BuildContext context) => RefreshIndicatorScreen(),
        name: 'RefreshIndicatorScreen'),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'Home',
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: renderButton(),
            ),
          ),
        ));
  }

  List<Widget> renderButton() {
    List<Widget> listButton = screens.map(
      (screen) {
        return ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: screen.builder,
              ),
            );
          },
          child: Text(screen.name),
        );
      },
    ).toList();
    return listButton;
  }
}
