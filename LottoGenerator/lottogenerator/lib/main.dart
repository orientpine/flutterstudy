import 'package:flutter/material.dart';
import 'package:lottogenerator/home_screen/homescreen.dart';

void main() {
  runApp(MaterialApp(home: Root()));
}

class Root extends StatefulWidget {
  Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  // Lotto 감싸는 공의 색깔 정의
  Color color1 = Colors.red;
  Color color2 = Colors.orange;
  Color color3 = Colors.yellow;
  Color color4 = Colors.green;
  Color color5 = Colors.blue;
  Color color6 = Colors.purple;
  // 로또 번호 보이기
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: const Text(
          '로또 생성기',
          style: TextStyle(
            fontSize: 30,
          ),
        )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                  child: Center(
                child: show
                    ? HomeScreen(color1, color2, color3, color4, color5, color6)
                    : Container(),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    child: Text(
                      !show ? '번호 생성하기' : '번호 삭제하기',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
