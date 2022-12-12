import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/detalle/detalle.dart';
import 'package:sgrsoft/ui/widgets/modal/head.dart';

class TarjetaPuntoRecoleccion extends StatefulWidget {
  final PuntoRecoleccion puntoRecoleccion;
  const TarjetaPuntoRecoleccion({Key? key, required this.puntoRecoleccion})
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
                // onTap: () {
                //   Navigator.pushNamed(
                //       context, DetallePuntosRecoleccionScreens.routeName,
                //       arguments: DetallePuntoRecoleccionArguments(
                //           id: widget.puntoRecoleccion.id));
                // },
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const AppHeadModal(
                                title: "Punto de Recolección"),
                            titlePadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            insetPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            content: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(0),
                                constraints: BoxConstraints(
                                    maxHeight: kIsWeb
                                        ? 600
                                        : MediaQuery.of(context).size.height,
                                    maxWidth: 700),
                                child: DetallePuntosRecoleccionScreens(
                                    id: widget.puntoRecoleccion.id)));
                      });
                },
                child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff39ceb9),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0)),
                                color: Color(0xffe5f8f6),
                              ),
                              width: double.infinity,
                              child: Row(children: <Widget>[
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(Icons.auto_delete_outlined,
                                        size: 24.0, color: Color(0xff39ceb9))),
                                Text(
                                    widget.puntoRecoleccion.tipo.nombre
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.5)),
                              ])),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.grey.shade600,
                                ),
                                Text(
                                  widget.puntoRecoleccion.direccion,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.grey.shade800),
                                )
                              ])),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                widget.puntoRecoleccion.descripcion,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.grey.shade600),
                              )),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                widget.puntoRecoleccion.usuario.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.grey.shade600),
                              )),
                          const Divider(),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Row(children: [
                                Text(
                                  widget.puntoRecoleccion.estados![0].estado,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  DateFormat.MMMEd('es').format(widget
                                      .puntoRecoleccion.estados![0].fecha),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      ),
                                )
                              ]))
                        ],
                      ),
                    )))));
  }
}
