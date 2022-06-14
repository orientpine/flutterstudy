import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rannumgen/component/number_row.dart';
import 'package:rannumgen/constant/color.dart';
import 'package:rannumgen/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;
  List<int> randomNumbers = [
    12,
    34,
    56,
    78,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                _Header(
                  onPressed: onSettingsPop,
                ),
                _Body(randomNumbers: randomNumbers),
                _Footer(onPressed: onRandomNumberGerate)
              ],
            )),
      ),
    );
  }

  void onSettingsPop() async {
    //list - add
    // [HomeScreen() , SettingsScreen()]
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: ((BuildContext context) {
          return SettingsScreen(
            maxNumber: maxNumber,
          );
        }),
      ),
    );
    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }

  void onRandomNumberGerate() {
    {
      final rand = Random();
      final Set<int> newNumbers = {};
      while (newNumbers.length < 5) {
        final number = rand.nextInt(maxNumber);
        newNumbers.add(number);
      }
      setState(() {
        randomNumbers = newNumbers.toList();
      });
    }
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: RED_COLOR,
            ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;
  const _Body({required this.randomNumbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(
                    bottom: e.key == randomNumbers.length - 1 ? 0 : 16.0),
                child: NumberRow(
                  number: e.value,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: RED_COLOR,
        ),
        onPressed: onPressed,
        child: Text('생성하기'),
      ),
    );
  }
}