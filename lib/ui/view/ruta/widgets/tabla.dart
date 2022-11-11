import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

import 'dart:ui';

import 'package:sgrsoft/domain/models/ruta_punto.dart';

class RutasTabla extends StatefulWidget {
  final List<PuntoRecoleccion> rutas;
  const RutasTabla({super.key, required this.rutas});

  @override
  State<RutasTabla> createState() => _RutasTablaState();
}

class _RutasTablaState extends State<RutasTabla> {
  List<RutaPunto> rutas = [];

  @override
  void initState() {
    super.initState();
    for (int index = 0; index < widget.rutas.length; index += 1) {
      rutas.add(RutaPunto(orden: index, punto: widget.rutas[index]));
    }
    setState(() {
      rutas = rutas;
    });
  }

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
      shrinkWrap: true,
      // padding: const EdgeInsets.symmetric(horizontal: 40),
      proxyDecorator: proxyDecorator,
      children: <Widget>[
        for (int index = 0; index < rutas.length; index += 1)
          // ListTile(
          //     key: Key('$index'),
          //     title: Row(children: <Widget>[
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.delete),
          //   color: Colors.red,
          // ),
          ListTile(
            key: Key('$index'),
            tileColor: index.isOdd ? oddItemColor : evenItemColor,
            title: Text(rutas[index].punto.direccion),
            subtitle: Text(rutas[index].punto.tipo.nombre),
          )
        // ])),
      ],
      onReorder: (int oldIndex, int newIndex) {
        // rutas.sort((a, b) => a.orden.compareTo(b.orden));
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final RutaPunto item = rutas.removeAt(oldIndex);
          rutas.insert(newIndex, item);
        });
      },
    );
  }
}
