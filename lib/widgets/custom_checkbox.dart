import 'package:anosh_assignment/constants/font_sizes.dart';
import 'package:flutter/material.dart';

import '../constants/dimensions.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: Dimensions.width * .25,
          child: Checkbox(
            value: value,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            onChanged: onChanged,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            fillColor: WidgetStateProperty.all(Colors.black),
          ),
        ),
        Text(label,style: const TextStyle(
          fontSize: FontSizes.small
        ),),
      ],
    );
  }
}
