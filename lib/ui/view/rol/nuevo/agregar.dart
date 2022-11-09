// formluario para agregar un nuevo tipo de residuo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/rol/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/blocs/rol/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

class AgregarRolScreen extends StatefulWidget {
  const AgregarRolScreen({Key? key}) : super(key: key);

  @override
  AgregarRolScreenState createState() => AgregarRolScreenState();
}

class AgregarRolScreenState extends State<AgregarRolScreen> {
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
                  BlocProvider.of<NuevoRolBloc>(context)
                      .add(SaveNuevoRolEvent(rol: Rol(0, nombre)));
                  BlocProvider.of<ListadoRolBloc>(context)
                      .add(LoadListadoRolEvent());
                  Navigator.pop(context);
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
