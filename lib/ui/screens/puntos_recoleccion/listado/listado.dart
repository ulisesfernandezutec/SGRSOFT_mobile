import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/screens/puntos_recoleccion/listado/tarjeta.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/drawer.dart';
import 'package:sgrsoft/ui/widgets/menu_inferior.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: appDrawer(context),
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
            Center(
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: const [
                  TarjetaPuntoRecoleccion(
                      estado: 'Pendiente', titulo: 'Recolección de poda'),
                  TarjetaPuntoRecoleccion(
                      estado: 'Terminado', titulo: 'Recolección de poda'),
                  TarjetaPuntoRecoleccion(
                      estado: 'Rechazada', titulo: 'Recolección de poda'),
                  TarjetaPuntoRecoleccion(
                      estado: 'Pendiente', titulo: 'Recolección de poda'),
                  TarjetaPuntoRecoleccion(
                      estado: 'Terminado', titulo: 'Recolección de poda'),
                  TarjetaPuntoRecoleccion(
                      estado: 'Rechazada', titulo: 'Recolección de poda'),
                ],
              ),
            )
          ]),
        )),
        persistentFooterButtons: menuInferior(context));
  }
}
