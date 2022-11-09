// Formularo que permite editar un tipo de residuo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/rol/editar/editar_bloc.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

class EditarRolScreen extends StatefulWidget {
  final Rol rol;

  const EditarRolScreen({Key? key, required this.rol}) : super(key: key);

  @override
  EditarRolScreenState createState() => EditarRolScreenState();
}

class EditarRolScreenState extends State<EditarRolScreen> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  late Rol rol;

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.rol.nombre;
    rol = widget.rol;
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
                  rol.nombre = nombreController.text;
                  BlocProvider.of<EditarRolBloc>(context).add(
                    UpdateRolEvent(
                      rol: rol,
                    ),
                  );
                  // Puedo mandar un nuevo rol a la pantalla anterior
                  Navigator.pop(context, rol);
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
