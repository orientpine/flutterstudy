import 'package:calenderscheduler/database/drift_database.dart';
import 'package:calenderscheduler/model/schedule_with_color.dart';
import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TodayBanner extends StatelessWidget {
  final testStyle = TextStyle(
    color: lightColorScheme.background,
    fontWeight: FontWeight.w700,
  );
  final DateTime selectedDay;
  TodayBanner({
    required this.selectedDay,
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
            StreamBuilder<List<ScheduleWithColor>>(
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
                builder: (context, snapshot) {
                  int count = 0;

                  if (snapshot.hasData) {
                    count = snapshot.data!.length;
                  }
                  return Text(
                    '$count 개',
                    style: testStyle,
                  );
                })
          ],
        ),
      ),
    );
  }
}
