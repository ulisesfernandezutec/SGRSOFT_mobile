import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/screens/puntos_recoleccion/widgets/mapa.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/combo.dart';

class EditarPuntosRecoleccionScreens extends StatefulWidget {
  const EditarPuntosRecoleccionScreens({super.key});
  static const routeName = '/puntos_recoleccion/editar';

  @override
  // ignore: library_private_types_in_public_api
  EditarPuntosRecoleccionState createState() => EditarPuntosRecoleccionState();
}

class EditarPuntosRecoleccionState
    extends State<EditarPuntosRecoleccionScreens> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // double sceenWidth = MediaQuery.of(context).size.width;
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
                        'Editar de Punto de Recolección',
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
                      // Combo(
                      //     label: 'label',
                      //     value: 'Messaging',
                      //     items: const <String>[
                      //       'Messaging',
                      //       'Chating',
                      //       'No Longer Interested',
                      //       'Document Request'
                      //     ],
                      //     onChanged: ((p0) => null)),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                        width: double.infinity,
                        // height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(color: Colors.blueGrey)),
                        child: DropdownButton<String>(
                          autofocus: true,
                          hint: const Text("Messaging"),
                          items: <String>[
                            'Messaging',
                            'Chating',
                            'No Longer Interested',
                            'Document Request'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                          autofocus: true,
                          decoration: const InputDecoration(
                              labelText: 'Tipo de Solicitud',
                              border: OutlineInputBorder())),
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
                                onPressed: () => {},
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
