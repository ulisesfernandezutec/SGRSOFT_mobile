import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgrsoft/ui/view/demomodal/demomodal.dart';
import 'package:sgrsoft/ui/view/login/google.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/mapa/mapa.dart';
import 'package:sgrsoft/ui/view/ruta/add/add.dart';

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
    // IconButton(
    //   icon: const Icon(Icons.numbers),
    //   tooltip: 'Next page',
    //   onPressed: () {
    //     Navigator.pushNamed(context, PolylineMap.routeName);
    //   },
    // ),
    IconButton(
      icon: const Icon(Icons.search),
      tooltip: 'Next page',
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Container(
                color: Colors.transparent,
                margin: EdgeInsets.zero,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Container(
                              width: double.infinity,
                              // height: 300,
                              //borders redondeados para el container
                              padding: EdgeInsets.only(
                                // para que se ponga sobre el teclado y no por detras
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 5, 0, 0),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Icon(Icons.search,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                            Flexible(
                                                child: TextField(
                                              textInputAction:
                                                  TextInputAction.go,
                                              // controller: (_buscarControl),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Buscar',
                                              ),
                                              onSubmitted: (value) =>
                                                  log('sender serarch $value'),
                                              onChanged: (String e) {
                                                log('onChanged $e');
                                                // BlocProvider.of<ListadoPuntosRecoleccionBloc>(
                                                //         context)
                                                //     .add(FiltedListadoPuntosRecoleccionEvent(
                                                //         search: e));
                                              },
                                            ))
                                          ])),
                                  IconButton(
                                    onPressed: () async {
                                      final picked = await showDateRangePicker(
                                        context: context,
                                        lastDate: DateTime.now(),
                                        firstDate: DateTime(2019),
                                      );
//           if (picked != null && picked != null) {
//             print(picked);
//             setState(() {
//               startDate = picked.start;
//               endDate = picked.end;
// //below have methods that runs once a date range is picked
//               allWaterBillsFuture = _getAllWaterBillsFuture(
//                   picked.start.toIso8601String(),
//                   picked.end
//                       .add(new Duration(hours: 24))
//                       .toIso8601String());
//             });
//           }
                                    },
                                    icon: const Icon(
                                      Icons.calendar_today,
                                      // color: Colors.white,
                                    ),
                                  ),
                                  const ListTile(
                                    leading: Icon(Icons.copy),
                                    title: Text('Copy Link'),
                                  ),
                                  const ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                  ),
                                ],
                              )))
                    ]));
          },
        );
      },
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
    IconButton(
      icon: const Icon(FontAwesomeIcons.route),
      tooltip: 'AddRutaScreen',
      // color: Theme.of(context).primaryColor,
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
