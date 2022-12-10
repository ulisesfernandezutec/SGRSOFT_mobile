import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/blocs/ruta/nueva/nueva_bloc.dart';
import 'package:sgrsoft/domain/models/google_directions/google_bound.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

import 'datos.dart';
import 'mapa.dart';

typedef ValueChanged<T> = void Function(T value);

class NuevaRutaScreen extends StatefulWidget {
  const NuevaRutaScreen({super.key});

  @override
  NuevaRutaScreenState createState() => NuevaRutaScreenState();
}

class NuevaRutaScreenState extends State<NuevaRutaScreen> {
  int selectedStep = 0;
  Ruta ruta = Ruta(id: 0);
  Set<Marker> markers = {};

  final _formKey = GlobalKey<FormState>(debugLabel: '_nuevaRuta');
  final nombreController = TextEditingController();
  int idVehiculo = 0;
  int idChofer = 0;
  int idAdministrador = 0;
  GoogleBound bound = GoogleBound();
  List<PuntoMapa> puntos = [];
  int idSalida = 0;
  int idDisposicionFinal = 0;
  DateTime fecha = DateTime.now();

  // id de Puntos Mapa Seleccionados
  List<int> puntosSeleccionados = [];
  // Nombre
  List<PuntoSalida> puntosSalida = [];
  // Puntos de Dispocision Final
  List<PuntoDisposicionFinal> puntosDisposicionFinal = [];
  // Vehiculos
  List<Vehiculo> vehiculos = [];
  // Choferes
  List<Usuario> choferes = [];
  // Administradores
  List<Usuario> administradores = [];
  // Listado de puntos para las polylines
  List<LatLng> polylines = [];

  // Puntos seleccionados
  void changePuntosSeleccionados(int id) {
    if (puntosSeleccionados.contains(id)) {
      puntosSeleccionados.remove(id);
    } else {
      puntosSeleccionados.add(id);
    }
    setState(() {
      puntosSeleccionados = puntosSeleccionados;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _focusClear() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NuevaRutaBloc()..add(NuevaRutaEventInitialLoad()),
        child: BlocBuilder<NuevaRutaBloc, NuevaRutaState>(
            builder: (context, state) {
          if (state is NuevaRutaDatos) {
            puntosSalida = state.puntosSalida;
            puntosDisposicionFinal = state.puntosDisposicionFinal;
            vehiculos = state.vehiculos;
            choferes = state.choferes;
            administradores = state.administradores;
            puntos = state.puntos;
            ruta = state.ruta;
            polylines = state.polylines;
          }

          if (state is NuevaRutaLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor));
          } else {
            return GestureDetector(
                onTap: _focusClear,
                child: SafeArea(
                    child: Center(
                  child: Container(
                    // constraints: const BoxConstraints(maxWidth: 1300),
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
                                      constraints:
                                          const BoxConstraints(maxWidth: 500),
                                      child: StepDatos(
                                        formKey: _formKey,
                                        nombreController: nombreController,
                                        vehiculos: vehiculos,
                                        choferes: choferes,
                                        administradores: administradores,
                                        puntosSalida: puntosSalida,
                                        puntosDisposicionFinal:
                                            puntosDisposicionFinal,
                                      )))),
                          Step(
                              isActive: selectedStep >= 1,
                              title: const Text("Selección de Puntos"),
                              content: Column(children: <Widget>[
                                Card(
                                    elevation: 5,
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 200, maxWidth: 500),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .drawerTheme
                                              .backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.search,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          Expanded(
                                              child: TextField(
                                            // controller: _buscarControl,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Buscar',
                                            ),
                                            onChanged: (String e) {},
                                          )),
                                          // const Spacer(),
                                          Container(
                                            height: 38,
                                            // padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: const Color(0xff39ceb9), width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: TextButton.icon(
                                              // <-- TextButton

                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.tune,
                                                size: 24.0,
                                              ),
                                              label: const Text('Filtros'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                state is NuevaRutaDatos
                                    ? StepMap(
                                        polylines: polylines,
                                        ruta: ruta,
                                        puntos: puntos,
                                        seleccionados: puntosSeleccionados,
                                        puntosDisposicionFinal:
                                            puntosDisposicionFinal,
                                        puntosSalida: puntosSalida,
                                        onChange: changePuntosSeleccionados,
                                        onChangeDisposicionFinal: (value) {
                                          int id = value ?? 0;
                                          if (value != null) {
                                            BlocProvider.of<NuevaRutaBloc>(
                                                    context)
                                                .add(NuevaRutaEventChangeFinal(
                                                    id: id));
                                          }
                                        },
                                        onChangeSalida: (value) {
                                          int id = value ?? 0;
                                          if (value != null) {
                                            BlocProvider.of<NuevaRutaBloc>(
                                                    context)
                                                .add(NuevaRutaEventChangeSalida(
                                                    id: id));
                                          }
                                        },
                                      )
                                    : Container()
                              ]))
                        ]),
                  ),
                )));
          }
        }));
  }
}
