import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/vehiculo/listado/listado_bloc.dart';
import 'package:sgrsoft/ui/view/vehiculo/nuevo/agregar.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../detalle/detalle.dart';

class ListadoVehiculoScreen extends StatefulWidget {
  const ListadoVehiculoScreen({Key? key}) : super(key: key);

  static const routeName = '/vehiculo/listado';

  @override
  State<StatefulWidget> createState() {
    return ListadoVehiculoScreenState();
  }
}

class ListadoVehiculoScreenState extends State<ListadoVehiculoScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListadoVehiculoBloc>(context)
        .add(LoadListadoVehiculoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      // boton para agregar tipo de residuo
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgregarVehiculoScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ListadoVehiculoBloc, ListadoVehiculoState>(
          builder: (context, state) {
        if (state is ListadoInitialVehiculoState) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor));
        } else {
          return ListView.builder(
            itemCount: state.vehiculo.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.vehiculo[index].matricula ?? "sin matricula"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleVehiculoScreen(
                        vehiculo: state.vehiculo[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      }),
    );
  }
}
