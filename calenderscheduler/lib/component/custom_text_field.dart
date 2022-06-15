import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final bool isTime; //true 면 시간, 아니면 contents
  const CustomTextField({
    required this.title,
    required this.isTime,
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
    return TextField(
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
