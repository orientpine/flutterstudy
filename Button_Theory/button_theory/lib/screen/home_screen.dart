// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('button'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.purple;
                    }
                    return Colors.black;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.yellow;
                  },
                ),
                padding: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return EdgeInsets.all(100.0);
                  }
                  return EdgeInsets.all(20.0);
                }),
              ),
              child: Text('Button Style'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  // main color
                  primary: Colors.red,
                  // 글자 및 애니메이션 색깔
                  onPrimary: Colors.black,
                  // 그림자 색깔
                  shadowColor: Colors.blue,
                  elevation: 20.0,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                  ),
                  padding: const EdgeInsets.all(10),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 4.0,
                  )),
              child: const Text('Elevated Button'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                primary: Colors.green,
                backgroundColor: Colors.yellow,
                elevation: 10,
              ),
              child: const Text('Outlined Button'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.amber,
                backgroundColor: Colors.green,
              ),
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            GestureDetector(
              onTap: () {
                print('test');
              },
              child: Container(
                color: Colors.yellow,
                width: 10,
                child: const Center(
                  child: Text('box'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
