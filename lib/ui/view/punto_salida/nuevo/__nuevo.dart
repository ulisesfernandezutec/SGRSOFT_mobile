// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sgrsoft/ui/widgets/app_bar.dart';
// import 'package:sgrsoft/ui/widgets/google_maps/position_select.dart';

// class NuevoPuntoSalidaScreen extends StatefulWidget {
//   const NuevoPuntoSalidaScreen({Key? key}) : super(key: key);

//   static const routeName = '/puntos_salida/nuevo';

//   @override
//   State<NuevoPuntoSalidaScreen> createState() => NuevoPuntoSalidaScreenState();
// }

// class NuevoPuntoSalidaScreenState extends State<NuevoPuntoSalidaScreen> {
//   void _onSelectPosition(LatLng position) {
//     Future<void>.delayed(const Duration(milliseconds: 250), () {
//       setState(() {
//         latitud = position.latitude;
//         longitud = position.longitude;
//       });
//     });
//     setState(() {
//       latitud = position.latitude;
//       longitud = position.longitude;
//     });
//   }

//   double longitud = 0;
//   double latitud = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: appBar(context),
//         body: Center(
//             child: Container(
//                 padding: const EdgeInsets.all(0),
//                 margin: const EdgeInsets.all(0),
//                 height: MediaQuery.of(context).size.height - 280,
//                 constraints: const BoxConstraints(maxWidth: 900),
//                 child: GoogleMapPositionSelect(
//                     latitude: latitud,
//                     longitude: longitud,
//                     onSelectPosition: (position) {
//                       _onSelectPosition(position);
//                     }))));
//   }
// }
