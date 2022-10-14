import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/screens/puntos_recoleccion/widgets/estado.dart';

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
  double cardWidth = 500.0;
  double cardHeight = 150.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Container(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.only(
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
                    const Spacer(),
                    EstadoWidget(estado: widget.estado)
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
        ));
  }
}

class EstadoServicio extends StatelessWidget {
  final String estado;
  const EstadoServicio({Key? key, required this.estado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.fromLTRB(5, 0, 0, 5),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(children: <Widget>[
          Text(
            estado,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.warning_outlined, color: Colors.yellowAccent)
        ]));
  }
}
