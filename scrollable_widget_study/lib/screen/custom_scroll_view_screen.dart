// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:scrollable_widget_study/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });
  // ignore: empty_constructor_bodies
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  // covariant - 상속된 클래스도 사용가능
  // oldDelegate - build가 실행이 됐을 때 이전 Delegate
  // this - 새로운 delegate
  // ShouldRebuild - 새로 build를 해야할지 말지 결정
  // false - build 안함
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.child != child;
  }
}

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
          renderSliverAppbar(),
          renderSliverPersistentHeader(),
          renderChildBuilderList(),
          renderSliverPersistentHeader(),
          renderChildBuilderGrid(),
          renderChildBuilderList(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderSliverPersistentHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              '신기하지?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        maxHeight: 150,
        minHeight: 75,
      ),
    );
  }

  // AppBar
  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      // 스크롤 했을 때 리스트의 중간에도 Appbar가 내려오게 할 수 있음.
      floating: true,
      // 스크롤을 해도 Appbar가 고정되어 있음.
      pinned: false,
      // 살짝만 움직여도 애니메이션은 풀로 동작함
      snap: true,
      stretch: true,
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
        title: Text(
          'FlexibleSpace',
        ),
      ),
      title: Text(
        'CustomScrollViewScreen',
      ),
    );
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
        childCount: 10,
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
