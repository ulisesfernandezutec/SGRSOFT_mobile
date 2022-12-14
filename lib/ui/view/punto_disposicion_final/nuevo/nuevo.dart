import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/repository/tipos_residuos.dart';
import 'package:sgrsoft/domain/blocs/punto_disposicion_final/add/nuevo_bloc.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/ui/const/forms.dart';
import 'package:sgrsoft/ui/const/web.dart';
import 'package:sgrsoft/ui/view/punto_disposicion_final/listado/listado.dart';
import 'package:sgrsoft/ui/widgets/google_maps/position_select.dart';
import 'package:sgrsoft/ui/widgets/google_maps/select_position.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

typedef ValueChanged<T> = void Function(T value);

class NuevoPuntoDisposicionFinalScreen extends StatefulWidget {
  const NuevoPuntoDisposicionFinalScreen({Key? key}) : super(key: key);

  static const routeName = '/puntos_disposicion_final/nuevo';

  @override
  State<NuevoPuntoDisposicionFinalScreen> createState() =>
      NuevoPuntoDisposicionFinalScreenState();
}

class NuevoPuntoDisposicionFinalScreenState
    extends State<NuevoPuntoDisposicionFinalScreen> {
  final getIt = GetIt.instance;
  late TiposDeResiduosRepository _tiposDeResiduosRepository;

  final nombreController = TextEditingController();
  final direccionController = TextEditingController();
  final descripcionController = TextEditingController();
  List<TipoDeResiduo> tiposResiduos = [];
  List<TipoDeResiduo> selectedTiposResiduos = [];
  double latitud = 0;
  double longitud = 0;

  int selectedStep = 0;
  final _formKey =
      GlobalKey<FormState>(debugLabel: '_nuevoPuntoDisposicionFinal');

  void funSelectTiposResiduos(List<int> tipos) async {
    selectedTiposResiduos =
        await _tiposDeResiduosRepository.getListByIds(tipos);
    setState(() {
      selectedTiposResiduos = selectedTiposResiduos;
    });
  }

  void funLoadTiposResiduos() async {
    tiposResiduos = await _tiposDeResiduosRepository.getList();
    setState(() {
      tiposResiduos = tiposResiduos;
    });
  }

  void _focusClear() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _tiposDeResiduosRepository = getIt();
    });
    funLoadTiposResiduos();
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
        child: BlocBuilder<NuevoPuntoDisposicionFinalBloc,
            NuevoPuntoDisposicionFinalState>(builder: (context, state) {
          latitud = state.puntoDisposicionFinal.latitud;
          longitud = state.puntoDisposicionFinal.longitud;
          if (state is NuevoPuntoDisposicionFinalLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor));
          } else {
            return GestureDetector(
                onTap: _focusClear,
                child: Center(
                    child: Container(
                        constraints: const BoxConstraints(
                            maxWidth: AppWebStyles.pageMaxWidthConstrain),
                        child: Stepper(
                            currentStep: selectedStep,
                            margin: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            elevation: 2,
                            controlsBuilder:
                                (context, ControlsDetails control) {
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
                                        style: const TextStyle(
                                            color: Colors.white)),
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
                                        style: const TextStyle(
                                            color: Colors.white)),
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
                                  BlocProvider.of<
                                              NuevoPuntoDisposicionFinalBloc>(
                                          context)
                                      .add(
                                          NuevoPuntoDisposicionFinalEventToMapa(
                                              nombre: nombreController.text,
                                              descripcion:
                                                  descripcionController.text,
                                              direccion:
                                                  direccionController.text,
                                              selectedTiposResiduos:
                                                  selectedTiposResiduos));
                                  setState(() {
                                    if (selectedStep < 1) {
                                      selectedStep = selectedStep + 1;
                                    }
                                  });
                                }
                              } else {
                                BlocProvider.of<NuevoPuntoDisposicionFinalBloc>(
                                        context)
                                    .add(NuevoPuntoDisposicionFinalEventSave());
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                    context,
                                    ListadoPuntoDisposicionFinalScreen
                                        .routeName);
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
                                  BlocProvider.of<
                                              NuevoPuntoDisposicionFinalBloc>(
                                          context)
                                      .add(
                                          NuevoPuntoDisposicionFinalEventToMapa(
                                              nombre: nombreController.text,
                                              descripcion:
                                                  descripcionController.text,
                                              direccion:
                                                  direccionController.text,
                                              selectedTiposResiduos:
                                                  selectedTiposResiduos));
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
                                          child: selectedStep == 0 &&
                                                  (state is NuevoPuntoDisposicionFinalDatos ||
                                                      state
                                                          is NuevoPuntoDisposicionFinalMapa)
                                              ? StepDatos(
                                                  nombreController:
                                                      nombreController,
                                                  descripcionController:
                                                      descripcionController,
                                                  direccionController:
                                                      direccionController,
                                                  formKey: _formKey,
                                                  selectedTiposResiduos:
                                                      selectedTiposResiduos,
                                                  tiposResiduos: tiposResiduos,
                                                  updateSeleced:
                                                      funSelectTiposResiduos)
                                              : Container()))),
                              Step(
                                isActive: selectedStep >= 1,
                                title: const Text("Ubicaci??n"),
                                content: state is NuevoPuntoDisposicionFinalMapa
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
                                            latitude: state
                                                .puntoDisposicionFinal.latitud,
                                            longitude: state
                                                .puntoDisposicionFinal.longitud,
                                            markers: {
                                              const MarkerId('markerd'): createDragMarker(
                                                  latitude: state
                                                      .puntoDisposicionFinal
                                                      .latitud,
                                                  longitude: state
                                                      .puntoDisposicionFinal
                                                      .longitud,
                                                  onSelectPosition: (position) =>
                                                      BlocProvider.of<NuevoPuntoDisposicionFinalBloc>(context).add(
                                                          NuevoPuntoDisposicionFinalEventSelectPoint(
                                                              punto: state
                                                                  .puntoDisposicionFinal,
                                                              latitud: position
                                                                  .latitude,
                                                              longitud: position
                                                                  .longitude)))
                                            },
                                            onSelectPosition: (position) {
                                              BlocProvider.of<
                                                          NuevoPuntoDisposicionFinalBloc>(
                                                      context)
                                                  .add(
                                                      NuevoPuntoDisposicionFinalEventSelectPoint(
                                                punto:
                                                    state.puntoDisposicionFinal,
                                                latitud: position.latitude,
                                                longitud: position.longitude,
                                              ));
                                              // _onSelectPosition();
                                            }))
                                    : Container(),
                              )
                            ]))));
          }
        }));
  }
}

class StepDatos extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController direccionController;
  final TextEditingController descripcionController;
  final GlobalKey<FormState> formKey;
  final List<TipoDeResiduo> selectedTiposResiduos;
  final List<TipoDeResiduo> tiposResiduos;
  final ValueChanged<List<int>> updateSeleced;
  const StepDatos(
      {super.key,
      required this.nombreController,
      required this.descripcionController,
      required this.direccionController,
      required this.formKey,
      required this.selectedTiposResiduos,
      required this.tiposResiduos,
      required this.updateSeleced});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: TextFormField(
                  validator: ((value) =>
                      value!.isEmpty ? "El nombre no puede estar vac??o" : null),
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
                      ? "La direcci??n no puede estar vac??a"
                      : null,
                  maxLines: 1,
                  controller: direccionController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Direcci??n',
                    hintText: 'Ingrese una direcci??n',
                    border: OutlineInputBorder(),
                  ))),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: TextFormField(
                minLines: 1,
                maxLines: 10,
                controller: descripcionController,
                decoration: const InputDecoration(
                    labelText: 'Descripci??n',
                    hintText: 'Ingrese una descripci??n',
                    border: OutlineInputBorder()),
              )),
          tiposResiduos.isNotEmpty
              ? Padding(
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
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
                    dataSource: tiposResiduos
                        .map((e) => {"nombre": e.nombre, "id": e.id.toInt()})
                        .toList(),
                    textField: 'nombre',
                    valueField: 'id',
                    okButtonLabel: 'SELECCIONAR',
                    cancelButtonLabel: 'CANCELAR',
                    hintWidget: const Text('Por favor seleccione uno o m??s'),
                    initialValue:
                        selectedTiposResiduos.map((e) => e.id.toInt()).toList(),
                    onSaved: (value) {
                      if (value == null) return;
                      List<int> iDs = List<int>.from(value);
                      updateSeleced(iDs);
                    },
                  ))
              : Container(
                  padding: const EdgeInsets.all(5),
                  child:
                      const Text("No se pudieron cargar los tipos de residuos"))
        ]));
  }
}
