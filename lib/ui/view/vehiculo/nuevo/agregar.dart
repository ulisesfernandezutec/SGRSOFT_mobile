// formluario para agregar un nuevo tipo de residuo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/vehiculo/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/blocs/vehiculo/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

class AgregarVehiculoScreen extends StatefulWidget {
  const AgregarVehiculoScreen({Key? key}) : super(key: key);

  @override
  AgregarVehiculoScreenState createState() => AgregarVehiculoScreenState();
}

class AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  final _formKey = GlobalKey<FormState>();
  String matricula = '';

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
                    return 'Por favor ingrese un matricula';
                  }
                  return null;
                },
                onChanged: (value) {
                  matricula = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NuevoVehiculoBloc>(context).add(
                      SaveNuevoVehiculoEvent(
                          vehiculo: Vehiculo(id: 0, matricula: matricula)));
                  BlocProvider.of<ListadoVehiculoBloc>(context)
                      .add(LoadListadoVehiculoEvent());
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
