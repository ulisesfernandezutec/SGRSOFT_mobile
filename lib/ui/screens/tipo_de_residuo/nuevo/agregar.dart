// formluario para agregar un nuevo tipo de residuo
import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

class AgregarTipoResiduo extends StatefulWidget {
  const AgregarTipoResiduo({Key? key}) : super(key: key);

  @override
  AgregarTipoResiduoState createState() => AgregarTipoResiduoState();
}

class AgregarTipoResiduoState extends State<AgregarTipoResiduo> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
                onChanged: (value) {
                  nombre = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // agregar tipo de residuo
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
