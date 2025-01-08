import 'package:anosh_assignment/constants/dimensions.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<String> dropdownMenuEntries;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropdownMenu({
    super.key,
    required this.dropdownMenuEntries,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width * .2,
      height: Dimensions.height * 0.6,// Adjust width as needed
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12), // Rounded borders
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        padding: const EdgeInsets.only(left: 5 ),
        borderRadius: BorderRadius.circular(12),
        hint: Padding(
          padding: EdgeInsets.only(left: Dimensions.width * .15),
          child: Text(dropdownMenuEntries.first),
        ),
        onChanged: onChanged,
        underline: const SizedBox(),
        // isExpanded: true,
        // isDense: true,
        items: dropdownMenuEntries.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width * .5),
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
