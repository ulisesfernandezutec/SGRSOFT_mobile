import 'package:flutter/material.dart';

class AppComboBox extends StatelessWidget {
  final lista = [
    {
      'id': 1,
      'nombre': 'Coca Cola',
    },
    {
      'id': 2,
      'nombre': 'Pepsi',
    }
  ];

  AppComboBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10),
              // ),
              border: OutlineInputBorder(
                // borderSide:
                //     BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              filled: true,
              contentPadding: const EdgeInsets.all(16),
              // fillColor: Colors.blueAccent,
            ),
            value: 1,
            hint: const Text("Seleccione un tipo de residuo"),
            items: lista
                .map((e) => DropdownMenuItem(
                    value: int.parse(e['id'].toString()),
                    child: Text(e['nombre'].toString())))
                .toList(),
            onChanged: (int? value) {}));
  }
}
