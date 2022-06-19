// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:scrollable_widget_study/const/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);
  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: prefer_const_literals_to_create_immutables
        body: CustomScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      slivers: [
        SliverAppBar(
          title: Text(
            'CustomScrollViewScreen',
          ),
        ),
        renderChildBuilderGrid(),
        renderChildBuilderList()
      ],
    ));
  }

  SliverList renderChildList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
    );
  }

  SliverList renderChildBuilderList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
        childCount: 100,
      ),
    );
  }

  SliverGrid renderChildGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  SliverGrid renderChildBuilderGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index),
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
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

  Widget testWidget() {
    return Column(
      children: [
        // 스크롤 가능한 widget이 column안에 있을 때에는 크기를 명시해주는(Expanded)가 필요함
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: rainbowColors
                .map(
                  (e) => renderContainer(
                    color: e,
                    index: rainbowColors.indexOf(e),
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: GridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 3,
            children: rainbowColors
                .map(
                  (e) => renderContainer(
                    color: e,
                    index: rainbowColors.indexOf(e),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
