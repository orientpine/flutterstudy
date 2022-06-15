// ignore_for_file: unused_import

import 'package:drift/drift.dart';

class Schedules extends Table {
  // PRIMART KEY
  IntColumn get id => integer().autoIncrement()(); // 자동으로 올라가게 된다.
  // 내용
  TextColumn get content => text()();
  // selected Date
  DateTimeColumn get date => dateTime()();
  // start time
  IntColumn get startTime => integer()();
  // end time
  IntColumn get endTime => integer()();
  // category color table ID
  IntColumn get colorID => integer()();

  // 생성날짜
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now(),
      )();
}
