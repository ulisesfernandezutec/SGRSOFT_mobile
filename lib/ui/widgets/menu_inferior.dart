import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgrsoft/ui/view/demomodal/demomodal.dart';
import 'package:sgrsoft/ui/view/login/google.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/mapa/mapa.dart';

List<Widget> menuInferior(BuildContext context) {
  const List<Widget> icons = <Widget>[
    Icon(Icons.list_alt_outlined),
    Icon(Icons.map_outlined),
  ];
  List<Widget> menu = [
    // SizedBox(
    //     height: 50,
    //     child:
    ToggleButtons(
      // direction: vertical ? Axis.vertical : Axis.horizontal,
      onPressed: (int index) {
        // setState(() {
        //   // The button that is tapped is set to true, and the others to false.
        //   for (int i = 0;
        //       i < _selectedWeather.length;
        //       i++) {
        //     _selectedWeather[i] = i == index;
        //   }
        // });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),

      selectedBorderColor: Colors.green[400],
      selectedColor: Colors.white,
      fillColor: Colors.green[400],
      color: Colors.green[400],
      isSelected: const [true, false],
      children: const <Widget>[
        Icon(Icons.list_alt_outlined),
        Icon(Icons.map_outlined),
      ],
      // )
    ),
    IconButton(
      icon: const Icon(Icons.screen_lock_landscape),
      tooltip: 'Modal',
      onPressed: () {
        Navigator.pushNamed(
          context,
          DemoModal.routeName,
        );
      },
    ),
    // IconButton(
    //   icon: const Icon(Icons.list),
    //   tooltip: 'Listado',
    //   onPressed: () {
    //     Navigator.pushNamed(
    //       context,
    //       ListadoPuntosRecoleccionScreens.routeName,
    //     );
    //   },
    // ),
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
    // IconButton(
    //   icon: const Icon(Icons.add),
    //   tooltip: 'Nuevo Punto de Recolección',
    //   color: Theme.of(context).primaryColor,
    //   onPressed: () {
    //     Navigator.pushNamed(
    //       context,
    //       '/puntos_recoleccion/nuevo',
    //     );
    //   },
    // ),
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
