import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';
import 'package:sgrsoft/ui/widgets/calendario.dart';
import 'package:sgrsoft/ui/widgets/forms/app_combo_box.dart';

class StepDatos extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nombreController;

  // Nombre
  final List<PuntoSalida> puntosSalida;
  // Puntos de Dispocision Final
  final List<PuntoDisposicionFinal> puntosDisposicionFinal;
  // Vehiculos
  final List<Vehiculo> vehiculos;
  // Choferes
  final List<Usuario> choferes;
  // Administradores
  final List<Usuario> administradores;

  const StepDatos(
      {super.key,
      required this.formKey,
      required this.nombreController,
      required this.puntosSalida,
      required this.puntosDisposicionFinal,
      required this.vehiculos,
      required this.choferes,
      required this.administradores});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "El nombre no puede estar vacío" : null,
                  maxLines: 1,
                  controller: nombreController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Ingrese un Nombre',
                    border: OutlineInputBorder(),
                  ))),
          CalendarWidget(
            selectDateFunction: (DateTime? date) {},
          ),
          AppComboBox(
            dataList:
                vehiculos.map((e) => {"id": e.id, "label": e.nombre}).toList(),
            hint: "Seleccione un Vehiculo",
            label: "Vehiculo",
            selectedValue: null,
            comboKey: "id",
            comboLabel: "label",
            onChanged: (value) => {},
          ),
          AppComboBox(
            dataList: choferes
                .map((e) => {"id": e.id, "label": "${e.nombre} ${e.apellido}"})
                .toList(),
            hint: "Seleccione un Chofer",
            label: "Chofer",
            selectedValue: null,
            comboKey: "id",
            comboLabel: "label",
            onChanged: (value) => {},
          ),

          // AppComboBox()
        ]));
  }
}
