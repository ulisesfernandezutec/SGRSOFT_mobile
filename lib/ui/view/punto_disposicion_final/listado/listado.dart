import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/punto_disposicion_final/list/listado_bloc.dart';
import 'package:sgrsoft/ui/const/web.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/modal/head.dart';

import '../nuevo/nuevo.dart';

class ListadoPuntoDisposicionFinalScreen extends StatelessWidget {
  const ListadoPuntoDisposicionFinalScreen({Key? key}) : super(key: key);

  static const routeName = '/puntos_disposicion_final/listado';

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
                    title: const AppHeadModal(
                        title: "Nuevo Punto de Disposición Final"),
                    titlePadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 0),
                    content: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(0),
                        constraints: BoxConstraints(
                            maxHeight: kIsWeb
                                ? 600
                                : MediaQuery.of(context).size.height,
                            maxWidth: 700),
                        child: const NuevoPuntoDisposicionFinalScreen()));
              });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
          create: (context) => ListadoPuntoDisposicionFinalBloc()
            ..add(ListadoPuntoDisposicionFinalEventCargar()),
          child: BlocBuilder<ListadoPuntoDisposicionFinalBloc,
              ListadoPuntoDisposicionFinalState>(
            builder: (context, state) {
              if (state is ListadoPuntoDisposicionFinalLoaded) {
                return Center(
                    child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                            maxWidth: AppWebStyles.pageMaxWidthConstrain),
                        child: Card(
                            elevation: 3,
                            child: ListView(
                              children: [
                                ...state.puntos
                                    .map((punto) => ListTile(
                                          title: Text(punto.nombre),
                                          subtitle:
                                              Text(punto.tipos.toString()),
                                          onTap: () {},
                                        ))
                                    .toList(),
                              ],
                            ))));
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
