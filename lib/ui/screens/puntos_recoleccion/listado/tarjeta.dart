import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/screens/puntos_recoleccion/detalle/detalle.dart';

class TarjetaPuntoRecoleccion extends StatefulWidget {
  final String estado;
  final String titulo;
  const TarjetaPuntoRecoleccion(
      {Key? key, required this.estado, required this.titulo})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TarjetaPuntoRecoleccionState createState() =>
      _TarjetaPuntoRecoleccionState();
}

class _TarjetaPuntoRecoleccionState extends State<TarjetaPuntoRecoleccion> {
  double cardWidth = double.infinity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
            child: InkWell(
                highlightColor: Theme.of(context).colorScheme.primary,
                // splashColor: Theme.of(context).colorScheme.primaryContainer,
                onTap: () {
                  Navigator.restorablePushNamed(
                      context, DetallePuntosRecoleccionScreens.routeName);
                },
                child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).drawerTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      constraints:
                          const BoxConstraints(minWidth: 200, maxWidth: 360),
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                // color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0)),
                              ),
                              width: double.infinity,
                              child: Row(children: <Widget>[
                                Center(
                                  child: Text(widget.titulo.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5)),
                                ),
                                // const Spacer(),
                                // EstadoWidget(estado: widget.estado)
                              ])),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              ),
                              child: Text(
                                widget.titulo,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ))
                        ],
                      ),
                    )))));
  }
}
