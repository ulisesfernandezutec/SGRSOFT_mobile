// formluario para agregar un nuevo tipo de residuo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/tipos_residuos/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/blocs/tipos_residuos/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/ui/view/tipo_de_residuo/listado/listado.dart';
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
                  BlocProvider.of<NuevoTipoDeResiduoBloc>(context).add(
                      SaveNuevoTipoDeResiduoEvent(
                          tipoDeResiduo: TipoDeResiduo(0, nombre)));
                  BlocProvider.of<ListadoTipoDeResiduosBloc>(context)
                      .add(LoadListadoTiposDeResiduosEvent());
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
