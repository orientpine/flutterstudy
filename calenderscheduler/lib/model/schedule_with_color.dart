// ignore_for_file: empty_constructor_bodies

import 'package:calenderscheduler/database/drift_database.dart';

class ScheduleWithColor {
  final Schedule schedule;
  final CategoryColor categoryColor;

  ScheduleWithColor({
    required this.schedule,
    required this.categoryColor,
  });
}
