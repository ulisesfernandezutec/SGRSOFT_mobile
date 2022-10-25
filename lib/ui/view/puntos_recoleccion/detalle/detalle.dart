// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/detalle/detalle_bloc.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/widgets/mapa.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../editar/editar.dart';

class DetallePuntosRecoleccionScreens extends StatefulWidget {
  const DetallePuntosRecoleccionScreens({super.key});
  static const routeName = '/puntos_recoleccion/detalle';

  @override
  // ignore: library_private_types_in_public_api
  DetallePuntosRecoleccionScreenState createState() =>
      DetallePuntosRecoleccionScreenState();
}

class DetallePuntosRecoleccionScreenState
    extends State<DetallePuntosRecoleccionScreens> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as DetallePuntoRecoleccionArguments;
    // double sceenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
        create: (context) => DetallePuntosRecoleccionBloc()
          ..add(GetDetallePuntosRecoleccionEvent(id: args.id)),
        child: BlocBuilder<DetallePuntosRecoleccionBloc,
            DetallePuntosRecoleccionState>(builder: (context, state) {
          if (state is DetalleSuccessPuntosRecoleccionState) {
            return Scaffold(
                appBar: appBar(context),
                body: SafeArea(
                    child: Center(
                        child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(children: <Widget>[
                    Center(
                        child: Container(
                      constraints:
                          const BoxConstraints(minWidth: 200, maxWidth: 900),
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).drawerTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Form(
                          key: _formKey,
                          child: Column(children: [
                            Text(
                              state.puntoRecoleccion.tipo.nombre,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Estado: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(state.puntoRecoleccion.estados![0].estado,
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Fecha de Solicitud: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                    DateFormat.yMd().format(state
                                        .puntoRecoleccion.estados![0].fecha),
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Detalle: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(state.puntoRecoleccion.estados![0].detalle,
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Dirección: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(state.puntoRecoleccion.direccion,
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Container(
                                width: double.infinity,
                                height: 300,
                                constraints:
                                    const BoxConstraints(maxWidth: 900),
                                child: MapaPuntosRecoleccionWidgets()),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ButtonBar(
                                  children: <Widget>[
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context,
                                            EditarPuntosRecoleccionScreens
                                                .routeName);
                                      },
                                      label: const Text('Editar'),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => {},
                                      label: const Text('Eliminar'),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ])),
                    )),
                  ]),
                ))));
          } else if (state is DetalleErrorPuntosRecoleccionState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}

class DetallePuntoRecoleccionArguments {
  int id;
  DetallePuntoRecoleccionArguments({required this.id});
}
