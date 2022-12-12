import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgrsoft/ui/view/demomodal/demomodal.dart';
import 'package:sgrsoft/ui/view/login/google.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/mapa/mapa.dart';

List<Widget> menuInferiorPuntosRecolecion(BuildContext context) {
  List<Widget> menu = [
    // SizedBox(
    //     height: 50,
    //     child:
    ToggleButtons(
      renderBorder: true,
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
      children: List<Widget>.generate(
          2,
          (index) => Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Container(
                  width: 45,
                  // height: 25,
                  alignment: Alignment.center,
                  child: Icon(index == 0
                      ? Icons.list_alt_outlined
                      : Icons.map_outlined)))),

      // )
    ),
  ];
  return menu;
}
