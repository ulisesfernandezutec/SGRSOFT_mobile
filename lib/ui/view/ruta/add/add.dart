import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/ruta/add/bloc.dart';
import 'package:sgrsoft/ui/view/ruta/add/datos.dart';
import 'package:sgrsoft/ui/view/ruta/add/mapa.dart';
import 'package:sgrsoft/ui/widgets/menu_inferior.dart';

class AddRutaScreen extends StatefulWidget {
  const AddRutaScreen({super.key});

  static const routeName = '/rutas/add';

  @override
  AddRutaScreenState createState() => AddRutaScreenState();
}

class AddRutaScreenState extends State<AddRutaScreen> {
  int selectedStep = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddRutaBloc>(context).add(const LoadAddRutaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nueva Ruta'),
        ),
        body: SafeArea(
            child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1300),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Stepper(
                currentStep: selectedStep,
                margin: EdgeInsets.zero,
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
                      content: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: const StepDatos()))),
                  Step(
                      isActive: selectedStep >= 1,
                      title: const Text("Selección de Puntos"),
                      content: Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: BlocBuilder<AddRutaBloc, AddRutaState>(
                              builder: (context, state) {
                            if (state is AddRutaReadyState) {
                              return StepMap(
                                  puntos: state.puntosRecoleccion,
                                  polylines: state.polylines,
                                  markers: state.markers);
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.green,
                              ));
                            }
                          })))
                ]),
          ),
        )));
  }
}
