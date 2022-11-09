import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/ui/view/ruta/add/datos.dart';
import 'package:sgrsoft/ui/view/ruta/add/mapa.dart';

class AddRutaScreen extends StatefulWidget {
  const AddRutaScreen({super.key});

  static const routeName = '/rutas/add';

  @override
  AddRutaScreenState createState() => AddRutaScreenState();
}

class AddRutaScreenState extends State<AddRutaScreen> {
  int selectedStep = 0;
  List<PuntoRecoleccion> puntos = [
    PuntoRecoleccion(1, -34.734501, -56.229366, TipoDeResiduo(1, 'Podas'),
        'Juan Ortiz 228', 'Se corto un paraiso muy grande', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 10, 1), 1, 'Pendiente', 'Pendiente de recoleccion')
    ]),
    PuntoRecoleccion(
        2,
        -34.725260,
        -56.201385,
        TipoDeResiduo(2, 'Residuos grandes'),
        'Juan Ortiz 229',
        'Ropero de madera grande', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 5, 13), 1, 'Pendiente', 'Pendiente de recoleccion')
    ]),
    PuntoRecoleccion(
        3,
        -34.739191,
        -56.222028,
        TipoDeResiduo(2, 'Residuos grandes'),
        'Juan Ortiz 2293',
        'Ropero de madera grande3', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 7, 4), 1, 'Pendiente3', 'Pendiente de recoleccion3')
    ]),
    PuntoRecoleccion(4, -34.718100, -56.224860, TipoDeResiduo(1, 'Podas'),
        'Juan Ortiz 444', '4', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 4, 4), 1, 'Pendiente4', 'Pendiente de recoleccion4')
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Ruta'),
      ),
      body: SafeArea(
        child: Stepper(
            currentStep: selectedStep,
            elevation: 2,
            onStepContinue: () {
              setState(() {
                if (selectedStep < 1) {
                  selectedStep = selectedStep + 1;
                } else {
                  selectedStep = 0;
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (selectedStep > 0) {
                  selectedStep = selectedStep - 1;
                } else {
                  selectedStep = 0;
                }
              });
            },
            onStepTapped: (step) {
              setState(() {
                selectedStep = step;
              });
            },
            type: StepperType.horizontal,
            steps: <Step>[
              Step(
                  isActive: selectedStep >= 0,
                  title: const Text("Datos"),
                  content: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: const StepDatos())),
              Step(
                  isActive: selectedStep >= 1,
                  title: const Text("Selección de Puntos"),
                  content: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: StepMap(puntos: puntos)))
            ]),
      ),
    );
  }
}
