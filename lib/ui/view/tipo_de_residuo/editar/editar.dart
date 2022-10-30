// Formularo que permite editar un tipo de residuo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/tipos_residuos/editar/editar_bloc.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

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
  late TipoDeResiduo tipoResiduo;

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.tipoResiduo.nombre;
    tipoResiduo = widget.tipoResiduo;
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
                  tipoResiduo.nombre = nombreController.text;
                  BlocProvider.of<EditarTipoDeResiduoBloc>(context).add(
                    UpdateTipoDeResiduoEvent(
                      tipoResiduo: tipoResiduo,
                    ),
                  );
                  Navigator.pop(context);
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
