import 'package:flutter/material.dart';
import 'package:scrollable_widget_study/const/colors.dart';
import 'package:scrollable_widget_study/layout/main_layout.dart';

class ReOrderableListViewScreen extends StatefulWidget {
  const ReOrderableListViewScreen({Key? key}) : super(key: key);

  @override
  State<ReOrderableListViewScreen> createState() =>
      _ReOrderableListViewScreenState();
}

class _ReOrderableListViewScreenState extends State<ReOrderableListViewScreen> {
  List<int> numbers = List<int>.generate(100, (index) => index);
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "ReOrderableListViewScreen",
      body: renderBuilder(),
    );
  }

  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
      onReorder: (oldIndex, newIndex) {
        setState(
          () {
            final item = numbers.removeAt(oldIndex);
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            numbers.insert(newIndex, item);
          },
        );
      },
    );
  }

  Widget renderBuilder() {
    return ReorderableListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return renderContainer(
          color: rainbowColors[numbers[index] % rainbowColors.length],
          index: numbers[index], // 이렇게 안하면 안바뀜
        );
      },
      itemCount: numbers.length,
      onReorder: (oldIndex, newIndex) {
        setState(
          () {
            final item = numbers.removeAt(oldIndex);
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            numbers.insert(newIndex, item);
          },
        );
      },
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      key: Key(index.toString()),
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
