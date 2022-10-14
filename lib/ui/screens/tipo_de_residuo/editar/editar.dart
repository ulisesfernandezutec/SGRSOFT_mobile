// Formularo que permite editar un tipo de residuo
import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../listado/listado.dart';

class EditarTipoResiduo extends StatefulWidget {
  final TipoDeResiduo tipoResiduo;

  const EditarTipoResiduo({Key? key, required this.tipoResiduo})
      : super(key: key);

  @override
  EditarTipoResiduoState createState() => EditarTipoResiduoState();
}

class EditarTipoResiduoState extends State<EditarTipoResiduo> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.tipoResiduo.nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListadoTipoResiduos(),
                    ),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
