import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgrsoft/domain/blocs/ruta/add/bloc.dart';
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
      shrinkWrap: true,
      // padding: const EdgeInsets.symmetric(horizontal: 40),
      proxyDecorator: proxyDecorator,
      children: <Widget>[
        for (int index = 0; index < ruta.puntos.length; index += 1)
          ListTile(
            key: Key('$index'),
            tileColor: index.isOdd ? oddItemColor : evenItemColor,
            title: Text(ruta.puntos[index].punto.direccion.toString()),
            subtitle: Row(children: <Widget>[
              Text(
                  "${ruta.puntos[index].googleDistance?.text ?? ""} | ${ruta.puntos[index].googleDuration?.text ?? ""}"),
              const Spacer(),
              const Icon(FontAwesomeIcons.truck),
            ]),
            leading: IconButton(
              onPressed: () {
                ruta.puntos.removeAt(index);
                BlocProvider.of<AddRutaBloc>(context)
                    .add(ActualizarAddRutaEvent(puntos: ruta.puntos));
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
            // trailing: Text('ss'),
          )
        // ])),
      ],
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final RutaPunto item = ruta.puntos.removeAt(oldIndex);
        ruta.puntos.insert(newIndex, item);
        BlocProvider.of<AddRutaBloc>(context)
            .add(ActualizarAddRutaEvent(puntos: ruta.puntos));
      },
    );
  }
}
