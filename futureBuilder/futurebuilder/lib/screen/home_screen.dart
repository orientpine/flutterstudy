import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(fontSize: 16.0);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<int>(
          future: getNumber(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {} // 데이터가 있을 때 위젯 렌더링
            if (snapshot.hasError) {} // 에러가 났을 때 위젯 렌더링
            // 로딩중일 때 위젯 렌더링
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'FutureBuilder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'ConState : ${snapshot.connectionState}',
                  style: textStyle,
                ),
                Row(children: [
                  Text(
                    'Data : ${snapshot.data}',
                  ),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    CircularProgressIndicator()
                ]),
                Text(
                  'Error: ${snapshot.error}',
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('setState'))
              ],
            );
          },
        ),
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    final random = Random();

    // throw Exception('에러가 발생했습니다.');

    return random.nextInt(100);
  }
}
