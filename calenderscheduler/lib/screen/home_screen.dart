// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:calenderscheduler/component/caldendar.dart';
import 'package:calenderscheduler/component/schedule_bottom_sheet.dart';
import 'package:calenderscheduler/component/schedule_card.dart';
import 'package:calenderscheduler/component/today_banner.dart';
import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            SizedBox(
              height: 8.0,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 3,
            ),
            SizedBox(
              height: 8.0,
            ),
            _ScheduleList(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ScheduleBottomSheet();
          },
          isScrollControlled: true, //화면 전체를 사용하고자 할 때
        );
      },
      child: Icon(
        Icons.add,
      ),
    );
  }

  onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    setState(
      () {
        this.selectedDay = selectedDay;
        this.focusedDay = selectedDay;
      },
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: ListView.separated(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return ScheduleCard(
              startTime: 12,
              endTime: 14,
              content: '프로그래밍 공부 $index',
              color: Colors.red,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 8.0,
            );
          },
        ),
      ),
    );
  }
}
