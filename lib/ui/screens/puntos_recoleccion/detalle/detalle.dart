import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/screens/puntos_recoleccion/widgets/mapa.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../editar/editar.dart';

class DetallePuntosRecoleccionScreens extends StatefulWidget {
  const DetallePuntosRecoleccionScreens({super.key});
  static const routeName = '/puntos_recoleccion/detalle';

  @override
  // ignore: library_private_types_in_public_api
  DetallePuntosRecoleccionState createState() =>
      DetallePuntosRecoleccionState();
}

class DetallePuntosRecoleccionState
    extends State<DetallePuntosRecoleccionScreens> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double sceenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: appBar(context),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(children: <Widget>[
            Center(
                child: Card(
              elevation: 5,
              child: Container(
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 900),
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).drawerTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      const Text(
                        'Detalle de Punto de Recolección',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Tipo: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text('Recolección de residuos',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Estado: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text('Pendiente', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Fecha de Solicitud: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text('16/10/2022'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Detalle: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text('La basura esta en la esquina de la casa'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Dirección: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text('Juan Ortiz 123'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                          width: double.infinity,
                          height: 300,
                          constraints: const BoxConstraints(maxWidth: 900),
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
                                  Navigator.pushNamed(context,
                                      EditarPuntosRecoleccionScreens.routeName);
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
              ),
            )),
          ]),
        ))));
  }
}
