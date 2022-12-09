import 'package:flutter/material.dart';

class AppComboBox extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;
  final String comboKey;
  final String comboLabel;
  final String hint;
  final String label;
  final int? selectedValue;
  final ValueChanged<int?>? onChanged;

  const AppComboBox(
      {super.key,
      required this.dataList,
      required this.comboKey,
      required this.comboLabel,
      required this.hint,
      required this.selectedValue,
      required this.label,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              filled: true,
              contentPadding: const EdgeInsets.all(16),
            ),
            value: selectedValue,
            hint: Text(hint),
            items: dataList
                .map((e) => DropdownMenuItem(
                    value: int.parse(e[comboKey].toString()),
                    child: Text(e[comboLabel].toString())))
                .toList(),
            onChanged: onChanged));
  }
}
