import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/listado/listado_bloc.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/drawer.dart';
import 'package:sgrsoft/ui/widgets/google_maps/show_all_position.dart';
import 'package:sgrsoft/ui/widgets/menu_inferior.dart';

class MapaPuntosRecoleccion extends StatefulWidget {
  const MapaPuntosRecoleccion({super.key});
  static const routeName = '/puntos_recoleccion/mapa';

  @override
  // ignore: library_private_types_in_public_api
  _MapaPuntosRecoleccionState createState() => _MapaPuntosRecoleccionState();
}

class _MapaPuntosRecoleccionState extends State<MapaPuntosRecoleccion> {
  String selectId = '';

  void selectMarker(String id) {
    setState(() {
      selectId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: appDrawer(context),
        body: SafeArea(
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
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Buscar',
                            ),
                          ),
                        ),
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
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ListadoPuntosRecoleccionBloc,
                  ListadoPuntosRecoleccionState>(
                builder: (context, state) {
                  return (Container(
                      width: double.infinity,
                      height: double.infinity,
                      constraints: const BoxConstraints(
                          // minWidth: 200,
                          maxWidth: 1200,
                          // minHeight: 200,
                          maxHeight: 800),
                      padding: const EdgeInsets.all(0),
                      child: GoogleMapsShowAllPositions(
                          key: const Key('mapa_puntos_recoleccion'),
                          puntos: state.puntosRecoleccion,
                          latitude: state.puntosRecoleccion[0].latitud,
                          longitude: state.puntosRecoleccion[0].longitud,
                          onSelectMarker: selectMarker,
                          selectedMarkerId: selectId)));
                },
              ),
            )
          ]),
        ),
        persistentFooterButtons: menuInferior(context));
  }
}
