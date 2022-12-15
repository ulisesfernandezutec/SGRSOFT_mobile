import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/ruta.dart';

import 'dart:ui';

import 'package:sgrsoft/domain/models/ruta_punto.dart';

class RutasTabla extends StatelessWidget {
  Ruta ruta;
  RutasTabla({super.key, required this.ruta});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);
    final Color draggableItemColor = colorScheme.secondary;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      // reverse: true,
      shrinkWrap: true,
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      // proxyDecorator: proxyDecorator,
      children: <Widget>[
        for (int index = 0;
            index < (ruta.puntos != null ? ruta.puntos!.length : 0);
            index += 1)
          Card(
            elevation: 2,
            key: Key('$index'),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Column(children: <Widget>[
                  Text(ruta.puntos![index].punto.direccion.toString()),
                  Row(children: <Widget>[
                    IconButton(
                      onPressed: () {
                        ruta.puntos!.removeAt(index);
                        // BlocProvider.of<AddRutaBloc>(context)
                        //     .add(ActualizarAddRutaEvent(puntos: ruta.puntos!));
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    Text(
                        "${ruta.puntos![index].distancia.toString() ?? ""} | ${ruta.puntos![index].tiempoTraslado.toString() ?? ""}"),
                    // const Spacer(),
                    // const Icon(FontAwesomeIcons.truck),
                  ]),
                ])),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final RutaPunto item = ruta.puntos!.removeAt(oldIndex);
        ruta.puntos!.insert(newIndex, item);
        // BlocProvider.of<AddRutaBloc>(context)
        //     .add(ActualizarAddRutaEvent(puntos: ruta.puntos!));
      },
    );
  }
}
