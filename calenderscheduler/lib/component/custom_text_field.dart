// ignore_for_file: unused_local_variable

import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final bool isTime; //true 면 시간, 아니면 contents
  final FormFieldSetter<String> onSaved;
  const CustomTextField({
    required this.title,
    required this.isTime,
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: lightColorScheme.primary,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        isTime
            ? renderTextField()
            : Expanded(
                child: renderTextField(),
              )
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved,
      // null이 return되면 에러가 없다.
      // 에러가 있으면 에러를 String으로 리턴해준다.
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '값을 입력해주세요';
        }

        if (isTime) {
          int time = int.parse(val);
          if (time < 0) {
            return '0 이상의 숫자를 입력해주세요';
          }
          if (time > 24) {
            return '24 이하의 숫자를 입력해주세요';
          }
        } else {
          if (val.length > 500) {
            return '500자 이하의 글자를 입력해주세요';
          }
        }

        return null;
      },
      expands: !isTime,
      cursorColor: lightColorScheme.inverseSurface,
      maxLines: isTime ? 1 : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: lightColorScheme.outline.withOpacity(.5),
      ),
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
    );
  }
}
