import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/punto_salida/list/listado_bloc.dart';
import 'package:sgrsoft/ui/view/punto_salida/nuevo/nuevo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

class ListadoPuntoSalidaScreen extends StatelessWidget {
  const ListadoPuntoSalidaScreen({Key? key}) : super(key: key);

  static const routeName = '/puntos_salida/listado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      // boton para agregar tipo de residuo
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NuevoPuntoSalidaScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
          create: (context) =>
              ListadoPuntoSalidaBloc()..add(ListadoPuntoSalidaEventCargar()),
          child: BlocBuilder<ListadoPuntoSalidaBloc, ListadoPuntoSalidaState>(
            builder: (context, state) {
              if (state is ListadoPuntoSalidaLoaded) {
                return ListView(
                  children: [
                    ...state.puntos
                        .map((punto) => ListTile(
                              title: Text(punto.direccion),
                              subtitle: Text(punto.descripcion),
                              onTap: () {},
                            ))
                        .toList(),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ));
              }
            },
          )),
    );
  }
}
