import 'package:calenderscheduler/screen/home_screen.dart';
import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calenderscheduler/database/drift_database.dart';

const DEFAULT_COLORS = [
  'E91E63', // 핑크부터
  'F44336',
  'FF9800',
  'FFEB3B',
  '4CAF50',
  '2196F3',
  '3F51B5',
  '9C27B0', // 보라까지
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  final database = LocalDatabase();

  final colors = await database.getCategoryColors();

  if (colors.isEmpty) {
    for (String color in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode: Value(color),
        ),
      );
    }
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        colorScheme: lightColorScheme,
      ),
      home: HomeScreen(),
    ),
  );
}
