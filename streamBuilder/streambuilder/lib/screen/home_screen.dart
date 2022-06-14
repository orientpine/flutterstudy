// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle textStyle = TextStyle(fontSize: 30.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<int>(
          stream: streamNumber(),
          builder: (
            BuildContext context,
            AsyncSnapshot<int> snapshot,
          ) {
            // if (!snapshot.hasData) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'StreamBuilder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text('ConState: ${snapshot.connectionState}'),
                Row(
                  children: [
                    Text('Data: ${snapshot.data}'),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      CircularProgressIndicator(),
                  ],
                ),
                Text('Error: ${snapshot.error}'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('get Number'))
              ],
            );
          },
        ),
      ),
    );
  }

  Future<int> getNumber() async {
    int number = Random().nextInt(100);

    await Future.delayed(Duration(seconds: 3));

    return number;
  }

  Stream<int> streamNumber() async* {
    for (var i = 0; i < 10; i++) {
      // if (i == 5) throw Exception('i==5');
      await Future.delayed(
        Duration(seconds: 1),
      );
      yield i;
    }
  }
}
