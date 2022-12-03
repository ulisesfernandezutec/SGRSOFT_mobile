import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/listado/listado_bloc.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/tarjeta.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/drawer.dart';
import 'package:sgrsoft/ui/widgets/menu_inferior.dart';
import 'package:sgrsoft/ui/widgets/modal/head.dart';
import 'package:sgrsoft/ui/widgets/search_bar.dart';

import '../nuevo/nuevo.dart';

class ListadoPuntosRecoleccionScreens extends StatefulWidget {
  const ListadoPuntosRecoleccionScreens({super.key});
  static const routeName = '/puntos_recoleccion/listado';

  @override
  // ignore: library_private_types_in_public_api
  _ListadoPuntosRecoleccionState createState() =>
      _ListadoPuntosRecoleccionState();
}

class _ListadoPuntosRecoleccionState
    extends State<ListadoPuntosRecoleccionScreens> {
  final TextEditingController _buscarControl = TextEditingController();
  late Bloc bloc;

  @override
  void initState() {
    super.initState();
    _buscarControl.text =
        BlocProvider.of<ListadoPuntosRecoleccionBloc>(context).getSearch;
    BlocProvider.of<ListadoPuntosRecoleccionBloc>(context)
        .add(LoadListadoPuntosRecoleccionEvent());
    bloc = BlocProvider.of<ListadoPuntosRecoleccionBloc>(context);
  }

  @override
  void dispose() {
    _buscarControl.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: appDrawer(context),
        // endDrawer: const Text("endDrawer"),
        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const AppHeadModal(
                          title: "Nuevo Punto de Recolección"),
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
                          child: const NuevoPuntosRecoleccionScreens()));
                });
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
          child: Column(children: <Widget>[
            Center(
              child: Card(
                  elevation: 5,
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 200, maxWidth: 500),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).drawerTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.search,
                            color: Theme.of(context).colorScheme.primary),
                        Expanded(
                            child: TextField(
                          controller: _buscarControl,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Buscar',
                          ),
                          onChanged: (String e) {
                            log('onChanged $e');
                            BlocProvider.of<ListadoPuntosRecoleccionBloc>(
                                    context)
                                .add(FiltedListadoPuntosRecoleccionEvent(
                                    search: e));
                          },
                        )),
                        // const Spacer(),
                        IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.sort,
                              color: Theme.of(context).colorScheme.primary),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0.5, 0),
                        ),
                        IconButton(
                            onPressed: () => {},
                            icon: Icon(Icons.filter_list,
                                color: Theme.of(context).colorScheme.primary),
                            padding: const EdgeInsets.fromLTRB(0, 0, 0.5, 0)),
                      ],
                    ),
                  )),
            ),
            // Stack(
            //   alignment: Alignment.topLeft,
            //   children: <Widget>[
            //     buildFloatingSearchBar(),
            //     Positioned(
            //       top: 100,
            //       left: 100,
            //       child: Container(
            //         height: 300,
            //         width: 300,
            //         color: Colors.amber,
            //         child: const Center(child: Text('Positioned')),
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.topRight,
            //       child: Container(
            //         height: 200,
            //         width: 200,
            //         color: Colors.brown,
            //         child: const Center(child: Text('Aligned')),
            //       ),
            //     ),
            //     Container(
            //       height: 100,
            //       width: 100,
            //       color: Colors.cyan,
            //       child: const Center(child: Text('Non-Positioned')),
            //     ),
            //   ],
            // ),
            // Positioned(
            //     top: 10,
            //     // right: 0,
            //     left: 10,
            //     // bottom: 0,
            //     child: Column(
            //       children: <Widget>[
            //         const Text("hola asd ad"),
            //         const Text("hola asd ad")
            //       ],
            //     )),
            Center(
              child: BlocBuilder<ListadoPuntosRecoleccionBloc,
                  ListadoPuntosRecoleccionState>(
                builder: (context, state) {
                  return Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: <Widget>[
                      if (state is ListadoInitialPuntosRecoleccionState)
                        const Center(child: CircularProgressIndicator()),
                      if (state is ListadoSuccessPuntosRecoleccionState)
                        for (final punto in state.puntosRecoleccion)
                          TarjetaPuntoRecoleccion(puntoRecoleccion: punto),
                      if (state is ListadoErrorPuntosRecoleccionState)
                        const Center(child: Text('Error')),
                    ],
                  );
                },
              ),
            )
          ]),
        )),
        persistentFooterButtons: menuInferior(context),
        persistentFooterAlignment: AlignmentDirectional.bottomCenter);
  }
}
