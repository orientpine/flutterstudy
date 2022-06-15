import 'package:drift/drift.dart';

class CategoryColors extends Table {
  // ID for colors
  IntColumn get id => integer().autoIncrement()();
  // HEX for colors
  TextColumn get hexCode => text()();
}
