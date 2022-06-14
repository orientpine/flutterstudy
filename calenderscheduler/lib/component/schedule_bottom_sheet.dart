// ignore_for_file: prefer_const_constructors

import 'package:calenderscheduler/component/custom_text_field.dart';
import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: lightColorScheme.background,
      height: (MediaQuery.of(context).size.height) / 2 + bottomInset,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomInset,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 16,
            bottom: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Time(),
              SizedBox(
                height: 10,
              ),
              _Contents(),
              SizedBox(
                height: 10,
              ),
              _ColorPicker(),
              SizedBox(
                height: 10,
              ),
              _SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // text field는 row일 때 항상 size를 정해줘야한다!s
        Expanded(child: CustomTextField(title: '시작 시간')),
        SizedBox(
          width: 20,
        ),
        Expanded(child: CustomTextField(title: '종료 시간')),
      ],
    );
  }
}

class _Contents extends StatelessWidget {
  const _Contents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(title: '내용');
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Wrap(
        spacing: 8.0,
        children: [
          renderColor(Colors.pink),
          renderColor(Colors.red),
          renderColor(Colors.orange),
          renderColor(Colors.yellow),
          renderColor(Colors.green),
          renderColor(Colors.blue),
          renderColor(Colors.purple),
        ],
      ),
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              '저장하기',
            ),
          ),
        ),
      ],
    );
  }
}
