// 업데이트를 위한 코드
// flutter pub run build_runner build
import 'dart:io';

import 'package:calenderscheduler/model/category_color.dart';
import 'package:calenderscheduler/model/schedule.dart';
import 'package:calenderscheduler/model/schedule_with_color.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  Future<Schedule> getSchedulesById(int id) {
    final query = select(schedules);
    query.where((tbl) => tbl.id.equals(id));
    return query.getSingle();
  }

  // 이게 정석
  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    final query = select(schedules).join(
      [
        innerJoin(
          categoryColors,
          categoryColors.id.equalsExp(
            schedules.colorID,
          ),
        )
      ],
    );
    query.where(schedules.date.equals(date));
    query.orderBy(
      [
        OrderingTerm.asc(schedules.startTime),
      ],
    );
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => ScheduleWithColor(
                  schedule: row.readTable(schedules),
                  categoryColor: row.readTable(categoryColors),
                ),
              )
              .toList(),
        );
  }

  // Future<int> removeSchedule(int id) {
  //   final query = delete(schedules);
  //   query.where((tbl) => tbl.id.equals(id));
  //   return query.go();
  // }

  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // Future<int> updateScheduleById(int id, SchedulesCompanion data) {
  //   final query = update(schedules);
  //   query.where((tbl) => tbl.id.equals(id));
  //   return query.write(data);
  // }

  Future<int> updateScheduleById(int id, SchedulesCompanion data) =>
      (update(schedules)..where((tbl) => tbl.id.equals(id))).write(data);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      return NativeDatabase(file);
    },
  );
}
