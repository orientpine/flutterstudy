import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;

  const Calendar({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      color: lightColorScheme.outline.withOpacity(.5),
      borderRadius: BorderRadius.circular(6.0),
    );
    final defaultTextStyle = TextStyle(
      color: lightColorScheme.secondary,
      fontWeight: FontWeight.w700,
    );
    return TableCalendar(
      daysOfWeekHeight: 20,
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1000),
      lastDay: DateTime(3000),
      // ignore: prefer_const_constructors
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        // ignore: prefer_const_constructors
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        return date.year == selectedDay.year &&
            date.month == selectedDay.month &&
            date.day == selectedDay.day;
      },
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: defaultBoxDeco,
        weekendDecoration: defaultBoxDeco,
        selectedDecoration: BoxDecoration(
          color: lightColorScheme.onPrimary,
          borderRadius: BorderRadius.circular(
            6.0,
          ),
          border: Border.all(
            color: lightColorScheme.primary,
            width: 2.0,
          ),
        ),
        // ignore: prefer_const_constructors
        outsideDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: lightColorScheme.primary,
        ),
      ),
    );
  }
}
