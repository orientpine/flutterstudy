// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_import

import 'package:calenderscheduler/component/caldendar.dart';
import 'package:calenderscheduler/component/schedule_bottom_sheet.dart';
import 'package:calenderscheduler/component/schedule_card.dart';
import 'package:calenderscheduler/component/today_banner.dart';
import 'package:calenderscheduler/database/drift_database.dart';
import 'package:calenderscheduler/model/schedule_with_color.dart';
import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now().toUtc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            ),
            SizedBox(
              height: 8.0,
            ),
            _ScheduleList(
              selectedDate: selectedDay,
            ),
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
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ScheduleBottomSheet(
              selectedDate: selectedDay,
            );
          },
          //화면 전체를 사용하고자 할 때
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
  DateTime selectedDate;
  _ScheduleList({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text('스케쥴이 없습니다.'),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final scheduleWithColor = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return ScheduleBottomSheet(
                            selectedDate: selectedDate,
                            scheduleId: scheduleWithColor.schedule.id,
                          );
                        },
                        //화면 전체를 사용하고자 할 때
                      );
                    },
                    child: Dismissible(
                      key: ObjectKey(scheduleWithColor.schedule.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (DismissDirection direction) {
                        GetIt.I<LocalDatabase>()
                            .removeSchedule(scheduleWithColor.schedule.id);
                      },
                      child: ScheduleCard(
                        startTime: scheduleWithColor.schedule.startTime,
                        endTime: scheduleWithColor.schedule.endTime,
                        content: scheduleWithColor.schedule.content,
                        color: Color(
                          int.parse(
                              'FF${scheduleWithColor.categoryColor.hexCode}',
                              radix: 16),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8.0,
                  );
                },
              );
            }),
      ),
    );
  }
}
