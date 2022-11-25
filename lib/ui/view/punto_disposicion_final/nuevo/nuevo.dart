import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/blocs/punto_disposicion_final/add/nuevo_bloc.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/ui/const/forms.dart';
import 'package:sgrsoft/ui/const/web.dart';
import 'package:sgrsoft/ui/view/punto_disposicion_final/listado/listado.dart';
import 'package:sgrsoft/ui/widgets/google_maps/position_select.dart';
import 'package:sgrsoft/ui/widgets/google_maps/select_position.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

// typedef ValueChanged<T> = void Function(T value);

class NuevoPuntoDisposicionFinalScreen extends StatefulWidget {
  const NuevoPuntoDisposicionFinalScreen({Key? key}) : super(key: key);

  static const routeName = '/puntos_disposicion_final/nuevo';

  @override
  State<NuevoPuntoDisposicionFinalScreen> createState() =>
      NuevoPuntoDisposicionFinalScreenState();
}

class NuevoPuntoDisposicionFinalScreenState
    extends State<NuevoPuntoDisposicionFinalScreen> {
  final nombreController = TextEditingController();
  final direccionController = TextEditingController();
  final descripcionController = TextEditingController();

  List<TipoDeResiduo> tiposResiduos = [];

  int selectedStep = 0;
  final _formKey =
      GlobalKey<FormState>(debugLabel: '_nuevoPuntoDisposicionFinal');

  void funSelectTiposResiduos(List<TipoDeResiduo> tiposResiduos) {
    setState(() {
      this.tiposResiduos = tiposResiduos;
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
    nombreController.dispose();
    direccionController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NuevoPuntoDisposicionFinalBloc()
          ..add(NuevoPuntoDisposicionFinalEventLoad()),
        child: Center(
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
                                control.currentStep == 0 ? "Salir" : "Atras",
                                style: const TextStyle(color: Colors.white)),
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
                                style: const TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              padding: FormConst.buttonPadding,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      );
                    },
                    onStepContinue: () {
                      if (selectedStep == 0) {
                        if (_formKey.currentState!.validate()) {
                          _focusClear();
                          BlocProvider.of<NuevoPuntoDisposicionFinalBloc>(
                                  context)
                              .add(NuevoPuntoDisposicionFinalEventToMapa(
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
                        BlocProvider.of<NuevoPuntoDisposicionFinalBloc>(context)
                            .add(NuevoPuntoDisposicionFinalEventSave());
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context,
                            ListadoPuntoDisposicionFinalScreen.routeName);
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
                          BlocProvider.of<NuevoPuntoDisposicionFinalBloc>(
                                  context)
                              .add(NuevoPuntoDisposicionFinalEventToMapa(
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
                                  child: StepDatos(
                                    nombreController: nombreController,
                                    descripcionController:
                                        descripcionController,
                                    direccionController: direccionController,
                                    formKey: _formKey,
                                    // tiposResiduos: state.tiposResiduos,
                                    // selectedTiposResiduos:
                                    //     state.puntoDisposicionFinal.tipos,
                                  )))),
                      Step(
                          isActive: selectedStep >= 1,
                          title: const Text("Ubicación"),
                          content: BlocBuilder<NuevoPuntoDisposicionFinalBloc,
                                  NuevoPuntoDisposicionFinalState>(
                              builder: (context, state) {
                            if (state is NuevoPuntoDisposicionFinalMapa) {
                              return Container(
                                  padding: const EdgeInsets.all(0),
                                  margin: const EdgeInsets.all(0),
                                  height: double.maxFinite,
                                  constraints: BoxConstraints(
                                      maxHeight: kIsWeb
                                          ? 450
                                          : MediaQuery.of(context).size.height -
                                              240),
                                  child: GoogleMapsSetPosition(
                                      latitude:
                                          state.puntoDisposicionFinal.latitud,
                                      longitude:
                                          state.puntoDisposicionFinal.longitud,
                                      markers: {
                                        const MarkerId('markerd'): createDragMarker(
                                            latitude: state
                                                .puntoDisposicionFinal.latitud,
                                            longitude: state
                                                .puntoDisposicionFinal.longitud,
                                            onSelectPosition: (position) => BlocProvider
                                                    .of<NuevoPuntoDisposicionFinalBloc>(
                                                        context)
                                                .add(NuevoPuntoDisposicionFinalEventSelectPoint(
                                                    punto: state
                                                        .puntoDisposicionFinal,
                                                    latitud: position.latitude,
                                                    longitud: position.longitude)))
                                      },
                                      onSelectPosition: (position) {
                                        BlocProvider.of<
                                                    NuevoPuntoDisposicionFinalBloc>(
                                                context)
                                            .add(
                                                NuevoPuntoDisposicionFinalEventSelectPoint(
                                          punto: state.puntoDisposicionFinal,
                                          latitud: position.latitude,
                                          longitud: position.longitude,
                                        ));
                                        // _onSelectPosition();
                                      }));
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor));
                            }
                          }))
                    ]))));
  }
}

class StepDatos extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController direccionController;
  final TextEditingController descripcionController;
  final GlobalKey<FormState> formKey;
  // final List<TipoDeResiduo> selectedTiposResiduos;
  // final List<TipoDeResiduo> tiposResiduos;
  const StepDatos({
    super.key,
    required this.nombreController,
    required this.descripcionController,
    required this.direccionController,
    required this.formKey,
    // required this.selectedTiposResiduos,
    // required this.tiposResiduos
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NuevoPuntoDisposicionFinalBloc()
          ..add(NuevoPuntoDisposicionFinalEventLoad()),
        child: Form(
            key: formKey,
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                      validator: ((value) => value!.isEmpty
                          ? "El nombre no puede estar vacío"
                          : null),
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
              BlocBuilder<NuevoPuntoDisposicionFinalBloc,
                  NuevoPuntoDisposicionFinalState>(builder: (context, state) {
                if (state is NuevoPuntoDisposicionFinalDatos) {
                  if (state.tiposResiduos.isNotEmpty) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: MultiSelectFormField(
                          autovalidate: AutovalidateMode.onUserInteraction,
                          chipBackGroundColor: Theme.of(context).primaryColor,
                          chipLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          // dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Theme.of(context).primaryColor,
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: const Text(
                            "Tipos de Residuos",
                            style: TextStyle(fontSize: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Por favor seleccione al menos un tipo de residuo';
                            }
                            return null;
                          },
                          dataSource: state.tiposResiduos
                              .map((e) =>
                                  {"nombre": e.nombre, "id": e.id.toInt()})
                              .toList(),
                          textField: 'nombre',
                          valueField: 'id',
                          okButtonLabel: 'SELECCIONAR',
                          cancelButtonLabel: 'CANCELAR',
                          hintWidget:
                              const Text('Por favor seleccione uno o más'),
                          initialValue: state.puntoDisposicionFinal.tipos
                              .map((e) =>
                                  {"nombre": e.nombre, "id": e.id.toInt()})
                              .toList(),
                          onSaved: (value) {
                            if (value == null) return;
                            List<int> iDs = List<int>.from(value);
                            BlocProvider.of<NuevoPuntoDisposicionFinalBloc>(
                                    context)
                                .add(NuevoPuntoDisposicionFinalEventSelectTipos(
                                    puntosIds: iDs));
                          },
                        ));
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor));
                  }
                } else {
                  return Container();
                }
              })
            ])));
  }
}
