import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final testStyle = TextStyle(
    color: lightColorScheme.background,
    fontWeight: FontWeight.w700,
  );
  final DateTime selectedDay;
  final int scheduleCount;
  TodayBanner({
    required this.selectedDay,
    required this.scheduleCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightColorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
              style: testStyle,
            ),
            Text(
              '$scheduleCount개',
              style: testStyle,
            )
          ],
        ),
      ),
    );
  }
}
