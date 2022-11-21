import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String? initialValue;
  int maxLines = 1;
  TextEditingController? controller;

  AppTextForm(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.initialValue,
      maxLines,
      controller});

  @override
  Widget build(BuildContext context) {
    return (Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
            autofocus: true,
            maxLines: maxLines,
            controller: controller,
            initialValue: initialValue,
            decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                border: const OutlineInputBorder()),
            onChanged: (e) {})));
  }
}
