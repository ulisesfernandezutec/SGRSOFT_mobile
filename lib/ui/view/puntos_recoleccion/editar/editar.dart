import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/widgets/mapa.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/calendario.dart';
import 'package:sgrsoft/ui/widgets/forms.dart';

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

  DateTime fecha = DateTime.now();
  TipoDeResiduo? tipoDeResiduo;

  selectDateFunction(date) {
    if (kDebugMode) {
      print(date);
    }
    setState(() {
      fecha = date;
    });
  }

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
                    const SizedBox(height: 10),
                    const Text(
                      'Editar de Punto de Recolección',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          border: OutlineInputBorder(
                            // borderSide:
                            //     BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          // fillColor: Colors.blueAccent,
                        ),
                        value: 1,
                        hint: const Text("Seleccione un tipo de residuo"),
                        items: const <DropdownMenuItem<int>>[
                          DropdownMenuItem(value: 1, child: Text('Papel')),
                          DropdownMenuItem(value: 2, child: Text('Poda'))
                        ],
                        onChanged: (e) {
                          // setState(() {
                          //   // tipoDeResiduo = e as TipoDeResiduo?;
                          // });
                        }),
                    const EspacioForm(),
                    const EspacioForm(),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          border: OutlineInputBorder(
                            // borderSide:
                            //     BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          // fillColor: Colors.blueAccent,
                        ),
                        value: 1,
                        hint: const Text("Seleccione un estado"),
                        items: const <DropdownMenuItem<int>>[
                          DropdownMenuItem(value: 1, child: Text('Pendiente')),
                          DropdownMenuItem(value: 2, child: Text('Aprobado')),
                          DropdownMenuItem(value: 3, child: Text('Terminado'))
                        ],
                        onChanged: (e) {
                          // setState(() {
                          //   // tipoDeResiduo = e as TipoDeResiduo?;
                          // });
                        }),
                    const EspacioForm(),
                    CalendarWidget(
                      selectDateFunction: selectDateFunction,
                      initialDate: null,
                      firstDate: null,
                      lastDate: null,
                      restorationId: null,
                    ),
                    const EspacioForm(),
                    TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                            labelText: 'Dirección',
                            border: OutlineInputBorder())),
                    const SizedBox(height: 15),
                    Container(
                        width: double.infinity,
                        height: 300,
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: MapaPuntosRecoleccionWidgets()),
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
            )),
          ]),
        ))));
  }
}
