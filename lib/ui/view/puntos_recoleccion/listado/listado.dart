import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/tarjeta.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/widgets/search_box.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/drawer.dart';
import 'package:sgrsoft/ui/widgets/modal/head.dart';

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

  bool filterExpand = false;
  SearchPuntosRecoleccionObject objSearch = SearchPuntosRecoleccionObject();
  List<TipoDeResiduo> tiposResiduos = [];

  @override
  void initState() {
    super.initState();
    _buscarControl.text = BlocProvider.of<ListadoPuntosRecoleccionBloc>(context)
            .objSearch
            .buscar ??
        "";
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
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title:
                        const AppHeadModal(title: "Nuevo Punto de Recolección"),
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
        child: Stack(
          // fit: StackFit.expand,
          children: [
            SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 70),
                child: Center(
                  child: BlocBuilder<ListadoPuntosRecoleccionBloc,
                      ListadoPuntosRecoleccionState>(
                    builder: (context, state) {
                      if (state is ListadoSuccessPuntosRecoleccionState) {
                        if (state.search != null) {
                          objSearch = state.search!;
                          tiposResiduos = state.tiposResiduo;
                        }

                        return Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: <Widget>[
                            for (final punto in state.puntosRecoleccion)
                              TarjetaPuntoRecoleccion(puntoRecoleccion: punto)
                          ],
                        );
                      } else if (state is ListadoErrorPuntosRecoleccionState) {
                        return const Center(child: Text('Error'));
                      } else {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height - 210,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      }
                    },
                  ),
                )),
            SearchBoxPuntosRecoleccion(
              objSearch: objSearch,
              filterExpand: filterExpand,
              tiposResiduos: tiposResiduos,
              buscarControl: _buscarControl,
              onBuscar: (value) =>
                  BlocProvider.of<ListadoPuntosRecoleccionBloc>(context)
                      .add(FiltedListadoPuntosRecoleccionEvent(buscar: value)),
              onTiposResiduosSelected: (value) {
                BlocProvider.of<ListadoPuntosRecoleccionBloc>(context)
                    .add(FiltedListadoPuntosRecoleccionEvent(tipos: value));
              },
              onFilterExpand: (value) {
                setState(() {
                  filterExpand = !filterExpand;
                });
              },
            )
          ],
        ),
      ),
      // persistentFooterButtons: menuInferiorPuntosRecolecion(context),
      // persistentFooterAlignment: AlignmentDirectional.center,
      // extendBody: true, // if you want body to be extended below buttons
      // bottomNavigationBar: SafeArea(
      //   child: Container(

      //     child: TextButton(
      //         child: Text('button'), onPressed: () {}), //or row of buttons
      //     width: 50,
      //     color: Colors.transparent, //background color
      //     padding: EdgeInsets.only(top: 5, bottom: 3),
      //   ),
      // ),
    );
  }
}
