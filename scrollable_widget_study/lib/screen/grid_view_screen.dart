import 'package:flutter/material.dart';
import 'package:scrollable_widget_study/const/colors.dart';
import 'package:scrollable_widget_study/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List<int>.generate(100, (index) => index);
  GridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext conext) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderBuild(),
    );
  }

  // 1
  // 한번에 다그림
  Widget renderCount() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      children: numbers
          .map(
            (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
          )
          .toList(),
    );
  }

  //2
  // 효율적으로 그림
  Widget renderBuild() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      itemCount: 100,
    );
  }

  //3
  // 각 위젯의 최대사이즈로 그림
  Widget renderMaxExtent() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      itemCount: 100,
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
