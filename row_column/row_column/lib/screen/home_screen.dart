import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            child: Column(
              // MainAxisAlignment - 주축 정렬
              // Start - 시작
              // end - 끝
              // center - 가운데
              // spacebetween - weget 과 weget의 배치가 동일하게
              // spaceevenly - weget 과 weget의 배치가 같은 간격으로
              //               배치하며 양 끝에도 공백을 둠
              // spacearound - spaceEvenly + 끝과 끝의 간격을 1/2
              mainAxisAlignment: MainAxisAlignment.start,
              // CrossAxisAlignment
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Expandable / Flexible
                Flexible(
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
