import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/blocs/punto_salida/add/nuevo_bloc.dart';
import 'package:sgrsoft/ui/const/forms.dart';
import 'package:sgrsoft/ui/const/web.dart';
import 'package:sgrsoft/ui/view/punto_salida/listado/listado.dart';
import 'package:sgrsoft/ui/widgets/google_maps/position_select.dart';
import 'package:sgrsoft/ui/widgets/google_maps/select_position.dart';

class NuevoPuntoSalidaScreen extends StatefulWidget {
  const NuevoPuntoSalidaScreen({Key? key}) : super(key: key);

  static const routeName = '/puntos_salida/nuevo';

  @override
  State<NuevoPuntoSalidaScreen> createState() => NuevoPuntoSalidaScreenState();
}

class NuevoPuntoSalidaScreenState extends State<NuevoPuntoSalidaScreen> {
  final nombreController = TextEditingController();
  final direccionController = TextEditingController();
  final descripcionController = TextEditingController();
  int selectedStep = 0;
  final _formKey = GlobalKey<FormState>();

  void _focusClear() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nombreController.dispose();
    direccionController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _focusClear,
        child: BlocBuilder<NuevoPuntoSalidaBloc, NuevoPuntoSalidaState>(
            builder: (context, state) {
          if (state is NuevoPuntoSalidaLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor));
          } else {
            return Center(
                child: Container(
                    constraints: const BoxConstraints(
                        maxWidth: AppWebStyles.pageMaxWidthConstrain),
                    child: Stepper(
                        currentStep: selectedStep,
                        margin: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        elevation: 2,
                        controlsBuilder: (context, ControlsDetails control) {
                          return ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                icon: Icon(
                                    control.currentStep == 0
                                        ? Icons.close
                                        : Icons.arrow_back,
                                    color: Colors.white),
                                onPressed: control.onStepCancel,
                                label: Text(
                                    control.currentStep == 0
                                        ? "Salir"
                                        : "Atras",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  padding: FormConst.buttonPadding,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              ElevatedButton.icon(
                                icon: Icon(
                                    control.currentStep == 0
                                        ? Icons.arrow_forward
                                        : Icons.save,
                                    color: Colors.white),
                                onPressed: control.onStepContinue,
                                label: Text(
                                    control.currentStep == 0
                                        ? "Siguiente"
                                        : "Guardar",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  padding: FormConst.buttonPadding,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          );
                        },
                        onStepContinue: () {
                          if (selectedStep == 0) {
                            if (_formKey.currentState!.validate()) {
                              _focusClear();
                              BlocProvider.of<NuevoPuntoSalidaBloc>(context)
                                  .add(NuevoPuntoSalidaEventToMapa(
                                      nombre: nombreController.text,
                                      descripcion: descripcionController.text,
                                      direccion: direccionController.text));
                              setState(() {
                                if (selectedStep < 1) {
                                  selectedStep = selectedStep + 1;
                                }
                              });
                            }
                          } else {
                            BlocProvider.of<NuevoPuntoSalidaBloc>(context)
                                .add(NuevoPuntoSalidaEventSave());
                            // Navigator.pushReplacementNamed(
                            //     context, ListadoPuntoSalidaScreen.routeName);
                            // Navigator.pop(context, true);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, ListadoPuntoSalidaScreen.routeName);
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) => super.widget));
                          }
                        },
                        onStepCancel: () {
                          setState(() {
                            if (selectedStep > 0) {
                              selectedStep = selectedStep - 1;
                            } else {
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        onStepTapped: (step) {
                          if (selectedStep == 0) {
                            _focusClear();
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<NuevoPuntoSalidaBloc>(context)
                                  .add(NuevoPuntoSalidaEventToMapa(
                                      nombre: nombreController.text,
                                      descripcion: descripcionController.text,
                                      direccion: direccionController.text));
                            } else {
                              return;
                            }
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
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      margin: EdgeInsets.zero,
                                      constraints: BoxConstraints(
                                          maxHeight: kIsWeb
                                              ? 450
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  240),
                                      child: StepDatos(
                                        nombreController: nombreController,
                                        descripcionController:
                                            descripcionController,
                                        direccionController:
                                            direccionController,
                                        formKey: _formKey,
                                      )))),
                          Step(
                            isActive: selectedStep >= 1,
                            title: const Text("Ubicación"),
                            content: state is NuevoPuntoSalidaMapa
                                ? Container(
                                    padding: const EdgeInsets.all(0),
                                    margin: const EdgeInsets.all(0),
                                    height: double.maxFinite,
                                    constraints: BoxConstraints(
                                        maxHeight: kIsWeb
                                            ? 450
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                240),
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
                                                      .add(
                                                          NuevoPuntoSalidaEventSelectPoint(
                                                              punto: state
                                                                  .puntoSalida,
                                                              latitud: position
                                                                  .latitude,
                                                              longitud: position
                                                                  .longitude)))
                                        },
                                        onSelectPosition: (position) {
                                          BlocProvider.of<NuevoPuntoSalidaBloc>(
                                                  context)
                                              .add(
                                                  NuevoPuntoSalidaEventSelectPoint(
                                                      punto: state.puntoSalida,
                                                      latitud:
                                                          position.latitude,
                                                      longitud:
                                                          position.longitude));
                                          // _onSelectPosition();
                                        }))
                                : Container(),
                          )
                        ])));
          }
        }));
  }
}

class StepDatos extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController direccionController;
  final TextEditingController descripcionController;
  final GlobalKey<FormState> formKey;
  const StepDatos(
      {super.key,
      required this.nombreController,
      required this.descripcionController,
      required this.direccionController,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: TextFormField(
                  validator: ((value) =>
                      value!.isEmpty ? "El nombre no puede estar vacío" : null),
                  maxLines: 1,
                  controller: nombreController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Ingrese un nombre',
                    border: OutlineInputBorder(),
                  ))),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: TextFormField(
                  validator: (value) => value!.isEmpty
                      ? "La dirección no puede estar vacía"
                      : null,
                  maxLines: 1,
                  controller: direccionController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                    hintText: 'Ingrese una dirección',
                    border: OutlineInputBorder(),
                  ))),
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
              )),
        ]));
  }
}
