import 'package:flutter/material.dart';

class AppTextForm extends StatelessWidget {
  final String hintText;
  final String labelText;

  const AppTextForm(
      {super.key, required this.labelText, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return (Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
            autofocus: true,
            // maxLines: 10,
            // controller: _descripcionController,
            decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                border: const OutlineInputBorder()),
            onChanged: (e) {})));
  }
}
