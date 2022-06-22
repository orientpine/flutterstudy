import 'package:flutter/material.dart';
import 'package:scrollable_widget_study/const/colors.dart';
import 'package:scrollable_widget_study/layout/main_layout.dart';

class ScollbarScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  ScollbarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildeScrollView',
      body: Scrollbar(
        interactive: true,
        child: SingleChildScrollView(
          child: Column(
            children: numbers
                .map(
                  (e) => renderContainer(
                      color: rainbowColors[e % rainbowColors.length], index: e),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
