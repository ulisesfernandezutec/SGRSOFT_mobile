import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/ruta/listado/listado_bloc.dart';
import 'package:sgrsoft/ui/const/web.dart';
import 'package:sgrsoft/ui/view/ruta/nueva/nueva.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/modal/head.dart';

class ListadoRutaScreen extends StatelessWidget {
  const ListadoRutaScreen({Key? key}) : super(key: key);

  static const routeName = '/rutas/listado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      // boton para agregar tipo de residuo
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const AppHeadModal(title: "Nueva Ruta"),
                    titlePadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 0),
                    content: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(0),
                        constraints: BoxConstraints(
                            maxHeight: kIsWeb
                                ? 800
                                : MediaQuery.of(context).size.height,
                            maxWidth: 1500),
                        child: const NuevaRutaScreen()));
              });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
          create: (context) =>
              ListadoRutaBloc()..add(const LoadListadoRutaEvent()),
          child: BlocBuilder<ListadoRutaBloc, ListadoRutaState>(
            builder: (context, state) {
              if (state is ListadoRutaSuccess) {
                return Center(
                    child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                            maxWidth: AppWebStyles.pageMaxWidthConstrain),
                        child: state.rutas.isNotEmpty
                            ? Card(
                                elevation: 3,
                                child: ListView(
                                  children: [
                                    ...state.rutas
                                        .map((ruta) => ListTile(
                                              title: Text(ruta.nombre ?? ""),
                                              subtitle: Text(
                                                  ruta.vehiculo!.matricula ??
                                                      ""),
                                              onTap: () {},
                                            ))
                                        .toList(),
                                  ],
                                ))
                            : Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.info_outline,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                              "  No hay datos para mostrar"
                                                  .toUpperCase(),
                                              overflow: TextOverflow.clip,
                                              softWrap: false,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6)
                                        ])))));
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
