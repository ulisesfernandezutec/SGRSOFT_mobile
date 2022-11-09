import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/view/login/google.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/mapa/mapa.dart';
import 'package:sgrsoft/ui/view/ruta/add/add.dart';
import 'package:sgrsoft/ui/widgets/google_maps/test.dart';

List<Widget> menuInferior(BuildContext context) {
  List<Widget> menu = [
    // IconButton(
    //   icon: const Icon(Icons.add_alert),
    //   tooltip: 'Show Snackbar',
    //   onPressed: () {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('This is a snackbar')),
    //     );
    //   },
    // ),
    IconButton(
      icon: const Icon(Icons.numbers),
      tooltip: 'Next page',
      onPressed: () {
        Navigator.pushNamed(context, PolylineMap.routeName);
      },
    ),
    // IconButton(
    //   icon: const Icon(Icons.navigate_next),
    //   tooltip: 'Next page',
    //   onPressed: () {
    //     Navigator.pushNamed(context, DemoParams.routeName,
    //         arguments: DemoParamsArguments(
    //             titulo: 'titulo2', subtitulo: 'subtitulo2', id: 2));
    //   },
    // ),
    // IconButton(
    //   icon: const Icon(Icons.screen_lock_landscape),
    //   tooltip: 'Modal',
    //   onPressed: () {
    //     Navigator.pushNamed(
    //       context,
    //       DemoModal.routeName,
    //     );
    //   },
    // ),
    IconButton(
      icon: const Icon(Icons.map_outlined),
      tooltip: 'AddRutaScreen',
      onPressed: () {
        Navigator.pushNamed(
          context,
          AddRutaScreen.routeName,
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.list),
      tooltip: 'Listado',
      onPressed: () {
        Navigator.pushNamed(
          context,
          ListadoPuntosRecoleccionScreens.routeName,
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.map_outlined),
      tooltip: 'Mapa',
      onPressed: () {
        Navigator.pushNamed(
          context,
          MapaPuntosRecoleccion.routeName,
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Nuevo Punto de Recolección',
      color: Theme.of(context).primaryColor,
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/puntos_recoleccion/nuevo',
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.login),
      tooltip: 'Google',
      color: Theme.of(context).primaryColor,
      onPressed: () {
        Navigator.pushNamed(context, SignInGoogle.routeName);
      },
    ),
  ];
  return menu;
}
