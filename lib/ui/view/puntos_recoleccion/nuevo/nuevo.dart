import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/repository/tipos_residuos.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/ui/const/forms.dart';
import 'package:sgrsoft/ui/const/web.dart';
import 'package:sgrsoft/ui/widgets/google_maps/position_select.dart';
import 'package:sgrsoft/ui/widgets/google_maps/select_position.dart';

typedef ValueChanged<T> = void Function(T value);

class NuevoPuntosRecoleccionScreens extends StatefulWidget {
  const NuevoPuntosRecoleccionScreens({Key? key}) : super(key: key);

  static const routeName = '/puntos_disposicion_final/nuevo';

  @override
  State<NuevoPuntosRecoleccionScreens> createState() =>
      NuevoPuntosRecoleccionScreensState();
}

class NuevoPuntosRecoleccionScreensState
    extends State<NuevoPuntosRecoleccionScreens> {
  final getIt = GetIt.instance;
  late TiposDeResiduosRepository _tiposDeResiduosRepository;

  final direccionController = TextEditingController();
  final descripcionController = TextEditingController();
  List<TipoDeResiduo> tiposResiduos = [];
  int? _indexTipoDeResiduo;

  int selectedStep = 0;
  final _formKey = GlobalKey<FormState>(debugLabel: '_nuevoPuntoRecoleccion');

  double latitud = 0;
  double longitud = 0;

  void funSelectTipoResiduo(int? tipo) async {
    setState(() {
      _indexTipoDeResiduo = tipo;
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
    direccionController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            NuevoPuntoRecoleccionBloc()..add(NuevoPuntoRecoleccionEventLoad()),
        child:
            BlocBuilder<NuevoPuntoRecoleccionBloc, NuevoPuntoRecoleccionState>(
                builder: (context, state) {
          longitud = state.puntoRecoleccion.longitud;
          latitud = state.puntoRecoleccion.latitud;
          if (state is NuevoPuntoRecoleccionLoading) {
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
                                  BlocProvider.of<NuevoPuntoRecoleccionBloc>(
                                          context)
                                      .add(NuevoPuntoRecoleccionEventToMapa(
                                          descripcion:
                                              descripcionController.text,
                                          direccion: direccionController.text,
                                          indexTipoDeResiduo:
                                              _indexTipoDeResiduo));
                                  setState(() {
                                    if (selectedStep < 1) {
                                      selectedStep = selectedStep + 1;
                                    }
                                  });
                                }
                              } else {
                                BlocProvider.of<NuevoPuntoRecoleccionBloc>(
                                        context)
                                    .add(NuevoPuntoRecoleccionEventSave());
                                Navigator.pop(context);
                                // Navigator.pushReplacementNamed(
                                //     context,
                                //     ListadoPuntoRecoleccionScreen
                                //         .routeName);
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
                                  BlocProvider.of<NuevoPuntoRecoleccionBloc>(
                                          context)
                                      .add(NuevoPuntoRecoleccionEventToMapa(
                                          descripcion:
                                              descripcionController.text,
                                          direccion: direccionController.text,
                                          indexTipoDeResiduo:
                                              _indexTipoDeResiduo));
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
                                                  (state is NuevoPuntoRecoleccionDatos ||
                                                      state
                                                          is NuevoPuntoRecoleccionMapa)
                                              ? StepDatos(
                                                  descripcionController:
                                                      descripcionController,
                                                  direccionController:
                                                      direccionController,
                                                  formKey: _formKey,
                                                  indexTipoDeResiduo:
                                                      _indexTipoDeResiduo,
                                                  tiposResiduos: tiposResiduos,
                                                  updateSeleced:
                                                      funSelectTipoResiduo)
                                              : Container()))),
                              Step(
                                isActive: selectedStep >= 1,
                                title: const Text("Ubicación"),
                                content: state is NuevoPuntoRecoleccionMapa
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
                                            latitude:
                                                state.puntoRecoleccion.latitud,
                                            longitude:
                                                state.puntoRecoleccion.longitud,
                                            markers: {
                                              const MarkerId('markerd'): createDragMarker(
                                                  latitude: state
                                                      .puntoRecoleccion.latitud,
                                                  longitude: state
                                                      .puntoRecoleccion
                                                      .longitud,
                                                  onSelectPosition: (position) =>
                                                      BlocProvider.of<NuevoPuntoRecoleccionBloc>(context).add(
                                                          NuevoPuntoRecoleccionEventSelectPoint(
                                                              punto: state
                                                                  .puntoRecoleccion,
                                                              latitud: position
                                                                  .latitude,
                                                              longitud: position
                                                                  .longitude)))
                                            },
                                            onSelectPosition: (position) {
                                              BlocProvider.of<
                                                          NuevoPuntoRecoleccionBloc>(
                                                      context)
                                                  .add(
                                                      NuevoPuntoRecoleccionEventSelectPoint(
                                                punto: state.puntoRecoleccion,
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
  final TextEditingController direccionController;
  final TextEditingController descripcionController;
  final GlobalKey<FormState> formKey;
  final int? indexTipoDeResiduo;
  final List<TipoDeResiduo> tiposResiduos;
  final ValueChanged<int?> updateSeleced;
  const StepDatos(
      {super.key,
      required this.descripcionController,
      required this.direccionController,
      required this.formKey,
      required this.indexTipoDeResiduo,
      required this.tiposResiduos,
      required this.updateSeleced});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(children: [
          tiposResiduos.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: DropdownButtonFormField(
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
                      validator: (value) => value == null
                          ? 'Seleccione un tipo de residuo'
                          : null,
                      value: indexTipoDeResiduo,
                      hint: const Text("Seleccione un tipo de residuo"),
                      items: tiposResiduos
                          .map((e) => DropdownMenuItem(
                              value: e.id, child: Text(e.nombre)))
                          .toList(),
                      onChanged: (int? value) {
                        updateSeleced(value);
                      }),
                )
              : Container(
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                      "No se pudieron cargar los tipos de residuos")),
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
