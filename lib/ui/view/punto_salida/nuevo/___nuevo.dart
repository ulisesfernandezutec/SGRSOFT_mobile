// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sgrsoft/domain/blocs/punto_salida/add/nuevo_bloc.dart';
// import 'package:sgrsoft/ui/asset_store/image_store.dart';
// import 'package:sgrsoft/ui/widgets/app_bar.dart';
// import 'package:sgrsoft/ui/widgets/google_maps/select_position.dart';

// class NuevoPuntoSalidaScreen extends StatefulWidget {
//   const NuevoPuntoSalidaScreen({Key? key}) : super(key: key);

//   static const routeName = '/puntos_salida/nuevo';

//   @override
//   State<NuevoPuntoSalidaScreen> createState() => NuevoPuntoSalidaScreenState();
// }

// class NuevoPuntoSalidaScreenState extends State<NuevoPuntoSalidaScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final direccionController = TextEditingController();
//   final descripcionController = TextEditingController();
//   String? direccion;
//   String? descripcion;

//   double latitud = .0;
//   double longitud = .0;

//   late GoogleMapController mapController;
//   Set<Marker> markers = {};

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     mapController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: appBar(context),
//         body: Form(
//             key: _formKey,
//             child: Center(child:
//                 BlocBuilder<NuevoPuntoSalidaBloc, NuevoPuntoSalidaState>(
//                     builder: (context, state) {
//               if (state is NuevoPuntoSalidaInitial ||
//                   state is NuevoPuntoSalidaDatos) {
//                 return Container(
//                     // width: double.infinity,
//                     // height: double.infinity,
//                     padding: const EdgeInsets.all(10),
//                     margin: const EdgeInsets.all(10),
//                     constraints: const BoxConstraints(maxWidth: 900),
//                     // color: Theme.of(context).backgroundColor,
//                     child: Column(
//                       children: [
//                         Text(
//                           "Nuevo Punto de Salida",
//                           // textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         const Divider(),
//                         Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
//                             child: TextFormField(
//                                 autofocus: true,
//                                 maxLines: 1,
//                                 controller: direccionController,
//                                 decoration: const InputDecoration(
//                                     labelText: 'Dirección',
//                                     hintText: 'Ingrese una dirección',
//                                     border: OutlineInputBorder()),
//                                 onChanged: (e) {})),
//                         Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
//                             child: TextFormField(
//                                 maxLines: 1,
//                                 controller: descripcionController,
//                                 decoration: const InputDecoration(
//                                     labelText: 'Descripción',
//                                     hintText: 'Ingrese una descripción',
//                                     border: OutlineInputBorder()),
//                                 onChanged: (e) {})),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               ButtonBar(
//                                 children: <Widget>[
//                                   ElevatedButton.icon(
//                                     icon: const Icon(Icons.arrow_back,
//                                         color: Colors.white),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     label: const Text('Cancelar',
//                                         style: TextStyle(color: Colors.white)),
//                                     style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                               Colors.grey),
//                                     ),
//                                   ),
//                                   ElevatedButton.icon(
//                                     icon: const Icon(
//                                       Icons.arrow_forward,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () async {
//                                       BlocProvider.of<NuevoPuntoSalidaBloc>(
//                                               context)
//                                           .add(NuevoPuntoSalidaEventToMapa(
//                                               direccion:
//                                                   direccionController.text,
//                                               descripcion:
//                                                   descripcionController.text));
//                                     },
//                                     label: const Text('Siguiente',
//                                         style: TextStyle(color: Colors.white)),
//                                     style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                               Theme.of(context).primaryColor),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ]),
//                       ],
//                     ));
//               } else if (state is NuevoPuntoSalidaMapa) {
//                 return Container(
//                     padding: const EdgeInsets.all(10),
//                     margin: const EdgeInsets.all(10),
//                     height: MediaQuery.of(context).size.height - 280,
//                     constraints: const BoxConstraints(maxWidth: 900),
//                     child: Column(
//                       children: [
//                         GoogleMapsSetPosition(
//                             latitude: state.puntoSalida.latitud,
//                             longitude: state.puntoSalida.longitud,
//                             markers: {
//                               const MarkerId("PuntoSalida"): Marker(
//                                   icon: ImageStore.markerIcon,
//                                   markerId: const MarkerId("markerSelect"),
//                                   position: LatLng(state.puntoSalida.latitud,
//                                       state.puntoSalida.longitud))
//                             },
//                             onSelectPosition: (position) {
//                               BlocProvider.of<NuevoPuntoSalidaBloc>(context)
//                                   .add(NuevoPuntoSalidaEventSelectPoint(
//                                       punto: state.puntoSalida,
//                                       latitud: position.latitude,
//                                       longitud: position.longitude));
//                               Future.delayed(const Duration(milliseconds: 250),
//                                   () {
//                                 setState(() {});
//                               });
//                             }),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               ButtonBar(
//                                 children: <Widget>[
//                                   ElevatedButton.icon(
//                                     icon: const Icon(Icons.arrow_back,
//                                         color: Colors.white),
//                                     onPressed: () {
//                                       BlocProvider.of<NuevoPuntoSalidaBloc>(
//                                               context)
//                                           .add(NuevoPuntoSalidaEventToData(
//                                               state.puntoSalida));
//                                     },
//                                     label: const Text('Atras',
//                                         style: TextStyle(color: Colors.white)),
//                                     style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                               Colors.grey),
//                                     ),
//                                   ),
//                                   ElevatedButton.icon(
//                                     icon: const Icon(
//                                       Icons.arrow_forward,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () async {
//                                       // _save();
//                                       // Navigator.pop(context);
//                                     },
//                                     label: const Text('Siguiente',
//                                         style: TextStyle(color: Colors.white)),
//                                     style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                               Theme.of(context).primaryColor),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ]),
//                       ],
//                     ));
//               } else {
//                 return Center(
//                     child: CircularProgressIndicator(
//                         color: Theme.of(context).primaryColor));
//               }
//             }))));
//   }
// }
