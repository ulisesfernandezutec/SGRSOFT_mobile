import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
// import 'package:sgrsoft/data/api/google_api.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/forms.dart';
import 'package:sgrsoft/ui/widgets/google_maps/select_position.dart';
import 'package:dio/dio.dart';

class NuevoPuntosRecoleccionScreens extends StatefulWidget {
  const NuevoPuntosRecoleccionScreens({super.key});
  static const routeName = '/puntos_recoleccion/nuevo';

  @override
  // ignore: library_private_types_in_public_api
  NuevoPuntosRecoleccionState createState() => NuevoPuntosRecoleccionState();
}

class NuevoPuntosRecoleccionState extends State<NuevoPuntosRecoleccionScreens> {
  final _formKey = GlobalKey<FormState>();

  final _direccionController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _latitudController = TextEditingController();
  final _longitudController = TextEditingController();

  double latitud = 0;
  double longitud = 0;

  bool mapLoad = true;

  int? _indexTipoDeResiduo;

  String direccionControl = '';

  GeocodingResponse? responseDireccions;
  // Para el mapa
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  GoogleMapController? mapController;

  void _save() {
    BlocProvider.of<NuevoPuntosRecoleccionBloc>(context).add(
        SaveNuevoPuntosRecoleccionEvent(
            descripcion: _descripcionController.text,
            direccion: _direccionController.text,
            latitud: latitud,
            longitud: longitud,
            idTipoDeResiduo: _indexTipoDeResiduo ?? 0));
  }

  void _onChangeDireccion() async {
    if (direccionControl != _direccionController.text) {
      setState(() {
        mapLoad = false;
      });
      try {
        final Dio dio = Dio();
        String direccion = _direccionController.text.replaceAll(' ', '+');
        var request = await dio.get(
            'https://maps.googleapis.com/maps/api/geocode/json?address=$direccion&key=AIzaSyC-ojOj6y2NTYM0TlP2-MSw4QURB9bUUUg');
        responseDireccions = GeocodingResponse.fromJson(request.data);
        if (responseDireccions!.results.isNotEmpty) {
          final location = responseDireccions!.results.first.geometry.location;
          _latitudController.text = location.lat.toString();
          _longitudController.text = location.lng.toString();
          _onSelectPosition(LatLng(location.lat, location.lng));
        }
        setState(() {
          direccionControl = _direccionController.text;
        });
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  void _onSelectPosition(LatLng position) {
    const MarkerId markerId = MarkerId('punto_recoleccion');

    final Marker marker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
      markerId: markerId,
      position: position,
      infoWindow: const InfoWindow(title: 'Punto de Recolección', snippet: ' '),
      onTap: () {
        if (kDebugMode) {
          print('Marker Tapped');
        }
      },
    );

    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        markers[markerId] = marker;
        mapLoad = true;
        latitud = position.latitude;
        longitud = position.longitude;
      });
    });

    setState(() {
      markers = {};
      mapLoad = true;
      latitud = position.latitude;
      longitud = position.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NuevoPuntosRecoleccionBloc>(context)
        .add(LoadNuevoPuntosRecoleccionEvent());
  }

  DateTime fecha = DateTime.now();
  TipoDeResiduo? tipoDeResiduo;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          appBar: appBar(context),
          body: SafeArea(child: BlocBuilder<NuevoPuntosRecoleccionBloc,
              NuevoPuntosRecoleccionBlocState>(builder: (context, state) {
            if (state is NuevoInitialPuntosRecoleccionBlocState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NuevoLoaderPuntosRecoleccionBlocState) {
              latitud = state.position.latitude;
              longitud = state.position.longitude;
              return Center(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(children: <Widget>[
                  Center(
                      child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 200, maxWidth: 900),
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
                            'Nuevo de Punto de Recolección',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                              value: _indexTipoDeResiduo,
                              hint: const Text("Seleccione un tipo de residuo"),
                              items: state.tiposDeResiduos
                                  .map((e) => DropdownMenuItem(
                                      value: e.id, child: Text(e.nombre)))
                                  .toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  _indexTipoDeResiduo = value!;
                                });
                              }),
                          const EspacioForm(),
                          const EspacioForm(),
                          TextFormField(
                              autofocus: true,
                              maxLines: 10,
                              controller: _descripcionController,
                              decoration: const InputDecoration(
                                  labelText: 'Descripción',
                                  hintText: 'Descripción',
                                  border: OutlineInputBorder()),
                              onChanged: (e) {}),
                          const EspacioForm(),
                          const EspacioForm(),
                          TextFormField(
                              autofocus: true,
                              controller: _direccionController,
                              decoration: const InputDecoration(
                                  labelText: 'Dirección',
                                  border: OutlineInputBorder()),
                              onChanged: (e) {
                                _onChangeDireccion();
                              }),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            height: 300,
                            constraints: const BoxConstraints(maxWidth: 900),
                            child: GoogleMapsSetPosition(
                                latitude: latitud,
                                longitude: longitud,
                                markers: markers,
                                onSelectPosition: _onSelectPosition),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ButtonBar(
                                children: <Widget>[
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.arrow_back,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    label: const Text('Cancelar',
                                        style: TextStyle(color: Colors.white)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.grey),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      _save();
                                      Navigator.pop(context);
                                    },
                                    label: const Text('Guardar',
                                        style: TextStyle(color: Colors.white)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ])),
                  )),
                ]),
              ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })));
    });
  }
}
