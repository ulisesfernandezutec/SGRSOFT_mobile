// Formularo que permite editar un tipo de residuo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/vehiculo/editar/editar_bloc.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

class EditarVehiculoScreen extends StatefulWidget {
  final Vehiculo vehiculo;

  const EditarVehiculoScreen({Key? key, required this.vehiculo})
      : super(key: key);

  @override
  EditarVehiculoScreenState createState() => EditarVehiculoScreenState();
}

class EditarVehiculoScreenState extends State<EditarVehiculoScreen> {
  final _formKey = GlobalKey<FormState>();
  final matriculaControl = TextEditingController();
  late Vehiculo vehiculo;

  @override
  void initState() {
    super.initState();
    matriculaControl.text = widget.vehiculo.matricula ?? "sin matricula";
    vehiculo = widget.vehiculo;
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
              controller: matriculaControl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una matricula';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  vehiculo.nombre = matriculaControl.text;
                  BlocProvider.of<EditarVehiculoBloc>(context).add(
                    UpdateVehiculoEvent(
                      vehiculo: vehiculo,
                    ),
                  );
                  // Puedo mandar un nuevo vehiculo a la pantalla anterior
                  Navigator.pop(context, vehiculo);
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
