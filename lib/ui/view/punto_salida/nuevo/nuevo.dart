import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/blocs/punto_salida/add/nuevo_bloc.dart';
import 'package:sgrsoft/ui/view/punto_salida/listado/listado.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/google_maps/position_select.dart';
import 'package:sgrsoft/ui/widgets/google_maps/select_position.dart';

class NuevoPuntoSalidaScreen extends StatefulWidget {
  const NuevoPuntoSalidaScreen({Key? key}) : super(key: key);

  static const routeName = '/puntos_salida/nuevo';

  @override
  State<NuevoPuntoSalidaScreen> createState() => NuevoPuntoSalidaScreenState();
}

class NuevoPuntoSalidaScreenState extends State<NuevoPuntoSalidaScreen> {
  final direccionController = TextEditingController();
  final descripcionController = TextEditingController();
  int selectedStep = 0;

  void _onSelectPosition() {
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {});
    });
  }

  void _focusClear() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    direccionController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: Center(
            child: Card(
                elevation: 3,
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 1300),
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Stepper(
                        currentStep: selectedStep,
                        margin: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        elevation: 2,
                        controlsBuilder: (context, ControlsDetails control) {
                          return Row(
                            children: <Widget>[
                              TextButton(
                                onPressed: control.onStepContinue,
                                child: const Text('NEXT'),
                              ),
                              TextButton(
                                onPressed: control.onStepCancel,
                                child: const Text('EXIT'),
                              ),
                            ],
                          );
                        },
                        onStepContinue: () {
                          if (selectedStep == 0) {
                            BlocProvider.of<NuevoPuntoSalidaBloc>(context).add(
                                NuevoPuntoSalidaEventToMapa(
                                    descripcion: descripcionController.text,
                                    direccion: direccionController.text));
                          }
                          if (selectedStep == 1) {
                            BlocProvider.of<NuevoPuntoSalidaBloc>(context)
                                .add(NuevoPuntoSalidaEventSave());
                            Navigator.restorablePushNamed(
                                context, ListadoPuntoSalidaScreen.routeName);
                          }
                          setState(() {
                            if (selectedStep < 1) {
                              selectedStep = selectedStep + 1;
                            }
                          });
                          if (kDebugMode) {
                            print(direccionController.text);
                          }
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
                          _focusClear();
                          if (selectedStep == 0) {
                            BlocProvider.of<NuevoPuntoSalidaBloc>(context).add(
                                NuevoPuntoSalidaEventToMapa(
                                    descripcion: descripcionController.text,
                                    direccion: direccionController.text));
                          }
                          setState(() {
                            selectedStep = step;
                          });
                        },
                        type: StepperType.horizontal,
                        steps: <Step>[
                          Step(
                              state: selectedStep > 0
                                  ? StepState.complete
                                  : StepState.indexed,
                              isActive: selectedStep >= 0,
                              title: const Text("Datos"),
                              content: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 500),
                                      child: StepDatos(
                                        descripcionController:
                                            descripcionController,
                                        direccionController:
                                            direccionController,
                                      )))),
                          Step(
                              isActive: selectedStep >= 1,
                              title: const Text("Confirmar Ubicación"),
                              content: BlocBuilder<NuevoPuntoSalidaBloc,
                                      NuevoPuntoSalidaState>(
                                  builder: (context, state) {
                                if (state is NuevoPuntoSalidaMapa) {
                                  return Container(
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.all(0),
                                      height:
                                          MediaQuery.of(context).size.height -
                                              280,
                                      constraints:
                                          const BoxConstraints(maxWidth: 900),
                                      child: GoogleMapsSetPosition(
                                          latitude: state.puntoSalida.latitud,
                                          longitude: state.puntoSalida.longitud,
                                          markers: {
                                            const MarkerId('markerd'): createDragMarker(
                                                latitude: state
                                                    .puntoSalida.latitud,
                                                longitude: state
                                                    .puntoSalida.longitud,
                                                onSelectPosition: (position) =>
                                                    BlocProvider.of<
                                                                NuevoPuntoSalidaBloc>(
                                                            context)
                                                        .add(NuevoPuntoSalidaEventSelectPoint(
                                                            punto: state
                                                                .puntoSalida,
                                                            latitud: position
                                                                .latitude,
                                                            longitud: position
                                                                .longitude)))
                                          },
                                          onSelectPosition: (position) {
                                            BlocProvider.of<
                                                        NuevoPuntoSalidaBloc>(
                                                    context)
                                                .add(
                                                    NuevoPuntoSalidaEventSelectPoint(
                                                        punto:
                                                            state.puntoSalida,
                                                        latitud:
                                                            position.latitude,
                                                        longitud: position
                                                            .longitude));
                                            // _onSelectPosition();
                                          }));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                          color:
                                              Theme.of(context).primaryColor));
                                }
                              }))
                        ])))));
  }
}

class StepDatos extends StatelessWidget {
  final TextEditingController direccionController;
  final TextEditingController descripcionController;
  StepDatos(
      {super.key,
      required this.descripcionController,
      required this.direccionController});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
            child: Container(
                // width: double.infinity,
                // height: double.infinity,
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                constraints: const BoxConstraints(maxWidth: 900),
                // color: Theme.of(context).backgroundColor,
                child: Column(children: [
                  Text(
                    "Nuevo Punto de Salida",
                    // textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: TextFormField(
                          // autofocus: true,
                          maxLines: 1,
                          controller: direccionController,
                          decoration: const InputDecoration(
                              labelText: 'Dirección',
                              hintText: 'Ingrese una dirección',
                              border: OutlineInputBorder()),
                          onChanged: (e) {})),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: descripcionController,
                          decoration: const InputDecoration(
                              labelText: 'Descripción',
                              hintText: 'Ingrese una descripción',
                              border: OutlineInputBorder()),
                          onChanged: (e) {})),
                ]))));
  }
}
