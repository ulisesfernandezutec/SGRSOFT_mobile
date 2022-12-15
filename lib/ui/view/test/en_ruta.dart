import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/device/dev_geolocator.dart';

class OnLIneRoute extends StatefulWidget {
  const OnLIneRoute({Key? key}) : super(key: key);

  static const routeName = '/test/online_route';

  @override
  OnLIneRouteState createState() => OnLIneRouteState();
}

class OnLIneRouteState extends State<OnLIneRoute> {
  // created controller to display Google Maps
  final Completer<GoogleMapController> _controller = Completer();
  //on below line we have set the camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(-34.738531, -56.226684),
    zoom: 14,
  );

  Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  LatLng coordenadas = const LatLng(-34.738531, -56.226684);

  void reset() {
    // declared for loop for various locations
    // for (int i = 0; i < latLen.length; i++) {
    //   _markers.add(
    //       // added markers
    //       Marker(
    //     markerId: MarkerId(i.toString()),
    //     position: latLen[i],
    //     infoWindow: InfoWindow(
    //       title: 'MARKER',
    //       snippet: 'id: ${i.toString()}',
    //     ),
    //     icon: BitmapDescriptor.defaultMarker,
    //   ));
    setState(() {});
    _polyline.add(Polyline(
      polylineId: const PolylineId('1'),
      points: latLen,
      color: Colors.green,
      width: 2,
    ));
    // }
  }

  void optimize() {
    List<LatLng> optimizado = latLen.sublist(1, latLen.length - 1);
    List<LatLng> optimizado2 = latLen.sublist(1, latLen.length - 1);
    LatLng start = latLen[0];
    LatLng end = latLen[latLen.length - 1];
    List<Map<String, int>> optimizedWaypoints = [
      {"providedIndex": 0, "optimizedIndex": 0},
      {"providedIndex": 1, "optimizedIndex": 3},
      {"providedIndex": 2, "optimizedIndex": 1},
      {"providedIndex": 3, "optimizedIndex": 8},
      {"providedIndex": 4, "optimizedIndex": 7},
      {"providedIndex": 5, "optimizedIndex": 2},
      {"providedIndex": 6, "optimizedIndex": 5},
      {"providedIndex": 7, "optimizedIndex": 6},
      {"providedIndex": 8, "optimizedIndex": 4}
    ];

    for (Map<String, int> m in optimizedWaypoints) {
      if (kDebugMode) {
        print(m.toString());
      }
      optimizado[m['optimizedIndex']!.toInt()] =
          optimizado2[m['providedIndex']!.toInt()];
    }
    optimizado.insert(0, start);
    optimizado.add(end);
    setState(() {});
    _polyline.add(Polyline(
      polylineId: const PolylineId('1'),
      points: optimizado,
      color: Colors.green,
      width: 2,
    ));
    // }
  }

  // list of locations to display polylines
  List<LatLng> latLen = [
    const LatLng(-34.738531, -56.226684), // 0   |
    const LatLng(-34.738522, -56.225622), // 1   | 0
    const LatLng(-34.738540, -56.227596), // 2   | 1
    const LatLng(-34.737473, -56.227811), // 3   | 2
    // const LatLng(-34.737491, -56.225676), // 4   | 3
    // const LatLng(-34.736433, -56.225665), // 5   | 4
    // const LatLng(-34.736391, -56.228929), // 6   | 5
    // const LatLng(-34.729918, -56.220479), // 7   | 6
    // const LatLng(-34.736788, -56.251053), // 8   | 7
    // const LatLng(-34.727102, -56.238742), // 9   | 8
    // const LatLng(-34.722136, -56.213936), // 10  | 9
    // const LatLng(-34.742923, -56.183552), // 11  | 10
    // const LatLng(-34.721941, -56.273403), // 12  | 11
    // const LatLng(-34.731821, -56.274276), // 13  | 12
    // const LatLng(-34.732214, -56.235603), // 14  | 13
    // const LatLng(-34.723372, -56.218681), // 15  | 14
    // const LatLng(-34.763736, -56.232988), // 16  | 15
    // const LatLng(-34.767635, -56.227845), // 17  | 16
    // const LatLng(-34.760817, -56.237330), // 18  | 17
    // const LatLng(-34.731387, -56.210533), // 19  | 18
    const LatLng(-34.744498, -56.241051), // 20  | 19
    const LatLng(-34.710651, -56.229224), // 21  | 20
    const LatLng(-34.734206, -56.229510), // 22  | 21
    const LatLng(-34.724879, -56.223937), // 23  | 22
    const LatLng(-34.751010, -56.248388), // 24  | 23
    const LatLng(-34.765238, -56.233218), // 25  | 24
    const LatLng(-34.732144, -56.234853) // 26   |
  ];

  void _getCoordenadas() async {
    Position position = await determinePosition();
    coordenadas = LatLng(position.latitude, position.longitude);
    print('lat: ${coordenadas.latitude} - lon: ${coordenadas.longitude}');
    _markers = {};
    _markers.add(
        // added markers
        Marker(
      markerId: const MarkerId('camion'),
      position: coordenadas,
      infoWindow: const InfoWindow(
        title: 'MARKER',
        snippet: 'id: auto',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    setState(() {
      coordenadas = coordenadas;
      _markers = _markers;
    });
  }

  @override
  void initState() {
    super.initState();

    // ejecuto el metodo para obtener las coordenadas cada 10 segundos.
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _getCoordenadas();
    });

    // declared for loop for various locations
    for (int i = 0; i < latLen.length; i++) {
      _markers.add(
          // added markers
          Marker(
        markerId: MarkerId(i.toString()),
        position: latLen[i],
        infoWindow: InfoWindow(
          title: 'MARKER',
          snippet: 'id: ${i.toString()}',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(
        polylineId: const PolylineId('1'),
        points: latLen,
        color: Colors.green,
        width: 2,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F9D58),
          // title of app
          title: const Text("GFG"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: GoogleMap(
                //given camera position
                initialCameraPosition: _kGoogle,
                // on below line we have given map type
                mapType: MapType.normal,
                // specified set of markers below
                markers: _markers,
                // on below line we have enabled location
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                // on below line we have enabled compass location
                compassEnabled: true,
                // on below line we have added polylines
                polylines: _polyline,
                // displayed google map
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              )),
              ButtonBar(alignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () async {
                    reset();
                  },
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    optimize();
                  },
                  child: const Text('Optimize'),
                ),
              ]),
            ],
          ),
        ));
  }
}
