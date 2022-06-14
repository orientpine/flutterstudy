import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  const CustomTextField({
    required this.title,
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
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: lightColorScheme.primary,
          ),
        ),
        TextField(
          cursorColor: lightColorScheme.inverseSurface,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: lightColorScheme.outline.withOpacity(.5),
          ),
        ),
      ],
    );
  }
}
