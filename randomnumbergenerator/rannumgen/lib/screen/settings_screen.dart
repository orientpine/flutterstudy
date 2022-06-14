import 'package:flutter/material.dart';
import 'package:rannumgen/component/number_row.dart';
import 'package:rannumgen/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;
  SettingsScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    maxNumber = widget.maxNumber.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(maxNumber: maxNumber),
              _Footer(
                maxNumber: maxNumber,
                onsliderChanged: onSliderChanged,
                onButtonPressed: onButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double value) {
    setState(() {
      maxNumber = value;
    });
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;
  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: NumberRow(
      number: maxNumber.toInt(),
    ));
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onsliderChanged;
  final VoidCallback onButtonPressed;
  const _Footer({
    required this.maxNumber,
    required this.onsliderChanged,
    required this.onButtonPressed,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Slider(
        value: maxNumber,
        min: 1000,
        max: 100000,
        onChanged: onsliderChanged,
      ),
      ElevatedButton(
        onPressed: onButtonPressed,
        child: Text('저장'),
        style: ElevatedButton.styleFrom(
          primary: RED_COLOR,
        ),
      )
    ]);
  }
}
