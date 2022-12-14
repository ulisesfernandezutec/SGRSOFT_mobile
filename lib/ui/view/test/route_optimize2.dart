import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteOptimize2 extends StatefulWidget {
  const RouteOptimize2({Key? key}) : super(key: key);

  static const routeName = '/test/route_optimize2';

  @override
  RouteOptimize2State createState() => RouteOptimize2State();
}

class RouteOptimize2State extends State<RouteOptimize2> {
  // created controller to display Google Maps
  final Completer<GoogleMapController> _controller = Completer();
  //on below line we have set the camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(-34.738531, -56.226684),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

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
      points: original,
      color: Colors.green,
      width: 2,
    ));
    // }
  }

  void optimize() {
    // List<LatLng> optimizado = latLen.sublist(1, latLen.length - 1);
    // List<LatLng> optimizado2 = latLen.sublist(1, latLen.length - 1);
    // LatLng start = latLen[0];
    // LatLng end = latLen[latLen.length - 1];
    // List<Map<String, int>> optimizedWaypoints = [
    //   {"providedIndex": 0, "optimizedIndex": 0},
    //   {"providedIndex": 1, "optimizedIndex": 3},
    //   {"providedIndex": 2, "optimizedIndex": 1},
    //   {"providedIndex": 3, "optimizedIndex": 8},
    //   {"providedIndex": 4, "optimizedIndex": 7},
    //   {"providedIndex": 5, "optimizedIndex": 2},
    //   {"providedIndex": 6, "optimizedIndex": 5},
    //   {"providedIndex": 7, "optimizedIndex": 6},
    //   {"providedIndex": 8, "optimizedIndex": 4}
    // ];

    // for (Map<String, int> m in optimizedWaypoints) {
    //   if (kDebugMode) {
    //     print(m.toString());
    //   }
    //   optimizado[m['optimizedIndex']!.toInt()] =
    //       optimizado2[m['providedIndex']!.toInt()];
    // }
    // optimizado.insert(0, start);
    // optimizado.add(end);
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
  List<LatLng> latLenMarkers = [
    const LatLng(-34.738531, -56.226684),
    const LatLng(-34.738522, -56.225622),
    const LatLng(-34.738540, -56.227596),
    const LatLng(-34.744498, -56.241051),
    const LatLng(-34.737473, -56.227811),
    const LatLng(-34.710651, -56.229224),
    const LatLng(-34.734206, -56.229510),
    const LatLng(-34.724879, -56.223937),
    const LatLng(-34.751010, -56.248388),
    const LatLng(-34.765238, -56.233218),
    const LatLng(-34.732144, -56.234853)
  ];

  List<LatLng> original = [
    const LatLng(-34.73857, -56.22671),
    const LatLng(-34.73857, -56.22563),
    const LatLng(-34.73852, -56.22563),
    const LatLng(-34.73852, -56.22563),
    const LatLng(-34.73751, -56.22564),
    const LatLng(-34.73751, -56.22669),
    const LatLng(-34.7375, -56.22757),
    const LatLng(-34.73857, -56.22759),
    const LatLng(-34.73857, -56.22759),
    const LatLng(-34.73877, -56.2276),
    const LatLng(-34.73962, -56.22761),
    const LatLng(-34.73961, -56.22803),
    const LatLng(-34.7396, -56.22858),
    const LatLng(-34.7396, -56.22927),
    const LatLng(-34.73959, -56.22954),
    const LatLng(-34.73943, -56.23017),
    const LatLng(-34.73912, -56.2314),
    const LatLng(-34.73884, -56.23264),
    const LatLng(-34.73877, -56.23293),
    const LatLng(-34.73848, -56.2342),
    const LatLng(-34.73843, -56.23442),
    const LatLng(-34.73825, -56.23519),
    const LatLng(-34.73746, -56.23864),
    const LatLng(-34.73873, -56.23897),
    const LatLng(-34.73877, -56.23898),
    const LatLng(-34.73965, -56.2392),
    const LatLng(-34.74158, -56.23969),
    const LatLng(-34.7427, -56.23997),
    const LatLng(-34.74354, -56.24018),
    const LatLng(-34.74412, -56.24032),
    const LatLng(-34.74482, -56.2405),
    const LatLng(-34.74504, -56.24056),
    const LatLng(-34.74493, -56.24116),
    const LatLng(-34.74493, -56.24116),
    const LatLng(-34.74427, -56.24488),
    const LatLng(-34.74426, -56.24493),
    const LatLng(-34.74424, -56.24494),
    const LatLng(-34.74419, -56.24494),
    const LatLng(-34.74366, -56.24477),
    const LatLng(-34.74419, -56.24494),
    const LatLng(-34.74424, -56.24494),
    const LatLng(-34.74426, -56.24493),
    const LatLng(-34.74427, -56.24488),
    const LatLng(-34.74504, -56.24056),
    const LatLng(-34.74482, -56.2405),
    const LatLng(-34.74412, -56.24032),
    const LatLng(-34.74354, -56.24018),
    const LatLng(-34.7427, -56.23997),
    const LatLng(-34.74158, -56.23969),
    const LatLng(-34.73965, -56.2392),
    const LatLng(-34.73877, -56.23898),
    const LatLng(-34.73873, -56.23897),
    const LatLng(-34.73746, -56.23864),
    const LatLng(-34.73825, -56.23519),
    const LatLng(-34.73843, -56.23442),
    const LatLng(-34.73848, -56.2342),
    const LatLng(-34.73799, -56.23406),
    const LatLng(-34.73782, -56.23402),
    const LatLng(-34.73735, -56.23396),
    const LatLng(-34.73746, -56.23356),
    const LatLng(-34.73747, -56.23347),
    const LatLng(-34.73746, -56.23262),
    const LatLng(-34.73748, -56.23139),
    const LatLng(-34.73748, -56.23015),
    const LatLng(-34.73748, -56.22884),
    const LatLng(-34.73748, -56.22853),
    const LatLng(-34.73749, -56.22803),
    const LatLng(-34.7375, -56.22782),
    const LatLng(-34.7375, -56.22782),
    const LatLng(-34.7375, -56.22757),
    const LatLng(-34.73645, -56.22758),
    const LatLng(-34.73539, -56.22759),
    const LatLng(-34.73432, -56.22757),
    const LatLng(-34.73328, -56.22757),
    const LatLng(-34.73221, -56.22758),
    const LatLng(-34.73217, -56.22758),
    const LatLng(-34.73122, -56.2276),
    const LatLng(-34.73017, -56.22762),
    const LatLng(-34.72953, -56.22763),
    const LatLng(-34.72924, -56.22763),
    const LatLng(-34.72834, -56.22764),
    const LatLng(-34.7274, -56.22764),
    const LatLng(-34.72654, -56.22764),
    const LatLng(-34.72637, -56.22764),
    const LatLng(-34.72628, -56.22761),
    const LatLng(-34.7262, -56.22761),
    const LatLng(-34.72612, -56.22759),
    const LatLng(-34.7261, -56.22754),
    const LatLng(-34.72607, -56.22753),
    const LatLng(-34.72605, -56.22752),
    const LatLng(-34.726, -56.22752),
    const LatLng(-34.72596, -56.22755),
    const LatLng(-34.72595, -56.22759),
    const LatLng(-34.72464, -56.2276),
    const LatLng(-34.72452, -56.2276),
    const LatLng(-34.72391, -56.22759),
    const LatLng(-34.72304, -56.22757),
    const LatLng(-34.72171, -56.22753),
    const LatLng(-34.72094, -56.22753),
    const LatLng(-34.7198, -56.22753),
    const LatLng(-34.71922, -56.22753),
    const LatLng(-34.71877, -56.22752),
    const LatLng(-34.71855, -56.22756),
    const LatLng(-34.71847, -56.22761),
    const LatLng(-34.71842, -56.22771),
    const LatLng(-34.71839, -56.22784),
    const LatLng(-34.71839, -56.22799),
    const LatLng(-34.71839, -56.22803),
    const LatLng(-34.71839, -56.22804),
    const LatLng(-34.71731, -56.22803),
    const LatLng(-34.7168, -56.22804),
    const LatLng(-34.71587, -56.22805),
    const LatLng(-34.71447, -56.22805),
    const LatLng(-34.71362, -56.22806),
    const LatLng(-34.71263, -56.22803),
    const LatLng(-34.71254, -56.22803),
    const LatLng(-34.71236, -56.22803),
    const LatLng(-34.71152, -56.22804),
    const LatLng(-34.71046, -56.22804),
    const LatLng(-34.71048, -56.22887),
    const LatLng(-34.71047, -56.22921),
    const LatLng(-34.71047, -56.22921),
    const LatLng(-34.71046, -56.22965),
    const LatLng(-34.71152, -56.22964),
    const LatLng(-34.71257, -56.22965),
    const LatLng(-34.71388, -56.22965),
    const LatLng(-34.71446, -56.22965),
    const LatLng(-34.71582, -56.22971),
    const LatLng(-34.7168, -56.22971),
    const LatLng(-34.71729, -56.2297),
    const LatLng(-34.71772, -56.22993),
    const LatLng(-34.71778, -56.22993),
    const LatLng(-34.71782, -56.22991),
    const LatLng(-34.71792, -56.22981),
    const LatLng(-34.71828, -56.22899),
    const LatLng(-34.71839, -56.229),
    const LatLng(-34.71839, -56.22914),
    const LatLng(-34.71921, -56.22913),
    const LatLng(-34.72008, -56.22913),
    const LatLng(-34.72095, -56.22912),
    const LatLng(-34.72171, -56.22912),
    const LatLng(-34.72303, -56.22914),
    const LatLng(-34.72394, -56.22915),
    const LatLng(-34.7247, -56.22916),
    const LatLng(-34.7254, -56.22916),
    const LatLng(-34.72553, -56.22887),
    const LatLng(-34.72657, -56.22881),
    const LatLng(-34.72744, -56.22874),
    const LatLng(-34.72769, -56.22872),
    const LatLng(-34.72832, -56.22872),
    const LatLng(-34.72861, -56.22872),
    const LatLng(-34.72918, -56.22874),
    const LatLng(-34.72954, -56.22879),
    const LatLng(-34.73018, -56.22881),
    const LatLng(-34.7312, -56.22883),
    const LatLng(-34.73217, -56.22886),
    const LatLng(-34.73225, -56.22887),
    const LatLng(-34.73327, -56.2288),
    const LatLng(-34.73432, -56.22881),
    const LatLng(-34.73432, -56.22951),
    const LatLng(-34.73432, -56.22951),
    const LatLng(-34.73432, -56.23012),
    const LatLng(-34.73326, -56.23011),
    const LatLng(-34.73221, -56.23012),
    const LatLng(-34.73119, -56.23015),
    const LatLng(-34.73019, -56.23011),
    const LatLng(-34.72954, -56.23008),
    const LatLng(-34.72828, -56.23011),
    const LatLng(-34.72748, -56.23012),
    const LatLng(-34.72744, -56.22874),
    const LatLng(-34.72741, -56.22803),
    const LatLng(-34.7274, -56.22764),
    const LatLng(-34.72737, -56.2269),
    const LatLng(-34.72733, -56.22584),
    const LatLng(-34.7273, -56.22477),
    const LatLng(-34.72726, -56.22375),
    const LatLng(-34.72632, -56.22378),
    const LatLng(-34.72539, -56.22376),
    const LatLng(-34.72488, -56.22376),
    const LatLng(-34.72488, -56.22376),
    const LatLng(-34.72448, -56.22376),
    const LatLng(-34.72452, -56.22394),
    const LatLng(-34.72454, -56.22497),
    const LatLng(-34.72454, -56.22596),
    const LatLng(-34.72453, -56.22671),
    const LatLng(-34.72452, -56.2276),
    const LatLng(-34.72464, -56.2276),
    const LatLng(-34.72595, -56.22759),
    const LatLng(-34.72595, -56.22762),
    const LatLng(-34.72595, -56.22764),
    const LatLng(-34.72596, -56.22769),
    const LatLng(-34.72599, -56.22771),
    const LatLng(-34.72603, -56.22772),
    const LatLng(-34.72605, -56.22771),
    const LatLng(-34.72607, -56.22771),
    const LatLng(-34.7261, -56.2277),
    const LatLng(-34.72611, -56.22769),
    const LatLng(-34.72612, -56.22768),
    const LatLng(-34.72631, -56.22767),
    const LatLng(-34.72637, -56.22764),
    const LatLng(-34.72654, -56.22764),
    const LatLng(-34.7274, -56.22764),
    const LatLng(-34.72834, -56.22764),
    const LatLng(-34.72924, -56.22763),
    const LatLng(-34.72953, -56.22763),
    const LatLng(-34.73017, -56.22762),
    const LatLng(-34.73122, -56.2276),
    const LatLng(-34.73217, -56.22758),
    const LatLng(-34.73221, -56.22758),
    const LatLng(-34.73328, -56.22757),
    const LatLng(-34.73327, -56.22803),
    const LatLng(-34.73327, -56.2288),
    const LatLng(-34.73326, -56.23011),
    const LatLng(-34.73325, -56.23136),
    const LatLng(-34.73328, -56.23261),
    const LatLng(-34.73325, -56.23382),
    const LatLng(-34.73325, -56.23491),
    const LatLng(-34.7343, -56.23498),
    const LatLng(-34.73534, -56.23499),
    const LatLng(-34.73642, -56.23507),
    const LatLng(-34.73698, -56.23511),
    const LatLng(-34.73772, -56.23515),
    const LatLng(-34.73825, -56.23519),
    const LatLng(-34.73746, -56.23864),
    const LatLng(-34.73873, -56.23897),
    const LatLng(-34.73877, -56.23898),
    const LatLng(-34.73965, -56.2392),
    const LatLng(-34.74158, -56.23969),
    const LatLng(-34.7427, -56.23997),
    const LatLng(-34.74354, -56.24018),
    const LatLng(-34.74412, -56.24032),
    const LatLng(-34.74482, -56.2405),
    const LatLng(-34.74504, -56.24056),
    const LatLng(-34.74657, -56.24095),
    const LatLng(-34.74733, -56.24113),
    const LatLng(-34.74793, -56.24128),
    const LatLng(-34.7486, -56.24145),
    const LatLng(-34.7493, -56.24163),
    const LatLng(-34.74992, -56.24177),
    const LatLng(-34.75026, -56.24185),
    const LatLng(-34.75034, -56.24187),
    const LatLng(-34.75232, -56.24237),
    const LatLng(-34.75191, -56.24424),
    const LatLng(-34.75175, -56.24492),
    const LatLng(-34.75159, -56.24568),
    const LatLng(-34.75134, -56.24681),
    const LatLng(-34.75121, -56.24735),
    const LatLng(-34.75098, -56.24838),
    const LatLng(-34.75098, -56.24838),
    const LatLng(-34.75095, -56.24853),
    const LatLng(-34.75093, -56.24897),
    const LatLng(-34.75093, -56.24905),
    const LatLng(-34.75095, -56.25),
    const LatLng(-34.75098, -56.2524),
    const LatLng(-34.75096, -56.25253),
    const LatLng(-34.74988, -56.25219),
    const LatLng(-34.74996, -56.25262),
    const LatLng(-34.75001, -56.25278),
    const LatLng(-34.75005, -56.25286),
    const LatLng(-34.75014, -56.25292),
    const LatLng(-34.75025, -56.25296),
    const LatLng(-34.7504, -56.25296),
    const LatLng(-34.75053, -56.25295),
    const LatLng(-34.75056, -56.25295),
    const LatLng(-34.75089, -56.2529),
    const LatLng(-34.75096, -56.25253),
    const LatLng(-34.75098, -56.2524),
    const LatLng(-34.75095, -56.25),
    const LatLng(-34.75093, -56.24905),
    const LatLng(-34.75093, -56.24897),
    const LatLng(-34.75095, -56.24853),
    const LatLng(-34.75121, -56.24735),
    const LatLng(-34.75134, -56.24681),
    const LatLng(-34.75159, -56.24568),
    const LatLng(-34.75175, -56.24492),
    const LatLng(-34.75191, -56.24424),
    const LatLng(-34.75232, -56.24237),
    const LatLng(-34.75261, -56.2411),
    const LatLng(-34.75278, -56.24037),
    const LatLng(-34.75285, -56.24003),
    const LatLng(-34.75395, -56.23886),
    const LatLng(-34.75435, -56.2384),
    const LatLng(-34.75449, -56.23794),
    const LatLng(-34.75468, -56.23677),
    const LatLng(-34.75469, -56.23651),
    const LatLng(-34.75473, -56.23441),
    const LatLng(-34.75476, -56.23321),
    const LatLng(-34.75574, -56.23322),
    const LatLng(-34.75674, -56.23322),
    const LatLng(-34.75781, -56.23325),
    const LatLng(-34.75895, -56.23323),
    const LatLng(-34.76009, -56.23324),
    const LatLng(-34.76074, -56.23324),
    const LatLng(-34.76083, -56.23324),
    const LatLng(-34.76105, -56.23324),
    const LatLng(-34.76151, -56.23323),
    const LatLng(-34.76187, -56.23322),
    const LatLng(-34.76196, -56.23322),
    const LatLng(-34.76287, -56.2332),
    const LatLng(-34.76335, -56.23319),
    const LatLng(-34.76381, -56.23317),
    const LatLng(-34.76475, -56.23319),
    const LatLng(-34.76524, -56.2332),
    const LatLng(-34.76524, -56.2332),
    const LatLng(-34.76537, -56.2332),
    const LatLng(-34.7654, -56.23218),
    const LatLng(-34.76474, -56.23219),
    const LatLng(-34.76381, -56.2322),
    const LatLng(-34.76335, -56.23221),
    const LatLng(-34.76287, -56.23222),
    const LatLng(-34.76195, -56.23223),
    const LatLng(-34.7615, -56.23224),
    const LatLng(-34.76104, -56.23224),
    const LatLng(-34.76074, -56.23225),
    const LatLng(-34.76007, -56.23226),
    const LatLng(-34.75915, -56.23225),
    const LatLng(-34.75895, -56.23323),
    const LatLng(-34.75781, -56.23325),
    const LatLng(-34.75674, -56.23322),
    const LatLng(-34.75574, -56.23322),
    const LatLng(-34.75476, -56.23321),
    const LatLng(-34.75326, -56.23325),
    const LatLng(-34.75186, -56.23327),
    const LatLng(-34.7507, -56.23327),
    const LatLng(-34.7497, -56.23328),
    const LatLng(-34.74836, -56.23327),
    const LatLng(-34.74738, -56.23327),
    const LatLng(-34.74697, -56.23327),
    const LatLng(-34.74563, -56.2332),
    const LatLng(-34.74563, -56.23236),
    const LatLng(-34.74563, -56.23163),
    const LatLng(-34.74562, -56.23158),
    const LatLng(-34.74559, -56.23154),
    const LatLng(-34.74555, -56.23152),
    const LatLng(-34.74549, -56.23151),
    const LatLng(-34.74385, -56.23146),
    const LatLng(-34.74349, -56.23146),
    const LatLng(-34.74327, -56.23146),
    const LatLng(-34.74205, -56.23143),
    const LatLng(-34.74068, -56.23141),
    const LatLng(-34.74006, -56.23141),
    const LatLng(-34.73912, -56.2314),
    const LatLng(-34.73884, -56.23264),
    const LatLng(-34.73877, -56.23293),
    const LatLng(-34.73848, -56.2342),
    const LatLng(-34.73843, -56.23442),
    const LatLng(-34.73825, -56.23519),
    const LatLng(-34.73772, -56.23515),
    const LatLng(-34.73698, -56.23511),
    const LatLng(-34.73642, -56.23507),
    const LatLng(-34.73534, -56.23499),
    const LatLng(-34.7343, -56.23498),
    const LatLng(-34.73325, -56.23491),
    const LatLng(-34.73221, -56.23484),
    const LatLng(-34.73214, -56.23484)
  ];

  // list of locations to display polylines
  List<LatLng> optimizado = [
    const LatLng(-34.73857, -56.22671),
    const LatLng(-34.73857, -56.22563),
    const LatLng(-34.73852, -56.22563),
    const LatLng(-34.73852, -56.22563),
    const LatLng(-34.73751, -56.22564),
    const LatLng(-34.73751, -56.22669),
    const LatLng(-34.7375, -56.22757),
    const LatLng(-34.7375, -56.22782),
    const LatLng(-34.7375, -56.22782),
    const LatLng(-34.73749, -56.22803),
    const LatLng(-34.73748, -56.22853),
    const LatLng(-34.73855, -56.22855),
    const LatLng(-34.73856, -56.22803),
    const LatLng(-34.73857, -56.22759),
    const LatLng(-34.73857, -56.22759),
    const LatLng(-34.73877, -56.2276),
    const LatLng(-34.73962, -56.22761),
    const LatLng(-34.74071, -56.22761),
    const LatLng(-34.74206, -56.22762),
    const LatLng(-34.74219, -56.22762),
    const LatLng(-34.74332, -56.22767),
    const LatLng(-34.74358, -56.22767),
    const LatLng(-34.74385, -56.22767),
    const LatLng(-34.74527, -56.2277),
    const LatLng(-34.74714, -56.2277),
    const LatLng(-34.74954, -56.22776),
    const LatLng(-34.74999, -56.22775),
    const LatLng(-34.75086, -56.22776),
    const LatLng(-34.75193, -56.22776),
    const LatLng(-34.75301, -56.22777),
    const LatLng(-34.75405, -56.22778),
    const LatLng(-34.75416, -56.22778),
    const LatLng(-34.75491, -56.22778),
    const LatLng(-34.75588, -56.22777),
    const LatLng(-34.7573, -56.22772),
    const LatLng(-34.75821, -56.22773),
    const LatLng(-34.75914, -56.22775),
    const LatLng(-34.76006, -56.22776),
    const LatLng(-34.76074, -56.22777),
    const LatLng(-34.761, -56.22777),
    const LatLng(-34.76193, -56.22779),
    const LatLng(-34.76285, -56.22776),
    const LatLng(-34.76381, -56.22773),
    const LatLng(-34.7647, -56.22775),
    const LatLng(-34.76471, -56.22803),
    const LatLng(-34.76471, -56.22885),
    const LatLng(-34.76472, -56.22999),
    const LatLng(-34.76473, -56.23111),
    const LatLng(-34.76474, -56.23219),
    const LatLng(-34.76475, -56.23319),
    const LatLng(-34.76524, -56.2332),
    const LatLng(-34.76524, -56.2332),
    const LatLng(-34.76537, -56.2332),
    const LatLng(-34.7654, -56.23218),
    const LatLng(-34.76474, -56.23219),
    const LatLng(-34.76381, -56.2322),
    const LatLng(-34.76335, -56.23221),
    const LatLng(-34.76287, -56.23222),
    const LatLng(-34.76195, -56.23223),
    const LatLng(-34.7615, -56.23224),
    const LatLng(-34.76104, -56.23224),
    const LatLng(-34.76074, -56.23225),
    const LatLng(-34.76007, -56.23226),
    const LatLng(-34.75915, -56.23225),
    const LatLng(-34.75822, -56.23229),
    const LatLng(-34.75781, -56.23232),
    const LatLng(-34.7574, -56.23228),
    const LatLng(-34.75659, -56.2323),
    const LatLng(-34.75575, -56.23231),
    const LatLng(-34.75478, -56.23225),
    const LatLng(-34.75476, -56.23321),
    const LatLng(-34.75473, -56.23441),
    const LatLng(-34.75469, -56.23651),
    const LatLng(-34.75468, -56.23677),
    const LatLng(-34.75449, -56.23794),
    const LatLng(-34.75435, -56.2384),
    const LatLng(-34.75395, -56.23886),
    const LatLng(-34.75285, -56.24003),
    const LatLng(-34.75278, -56.24037),
    const LatLng(-34.75261, -56.2411),
    const LatLng(-34.75232, -56.24237),
    const LatLng(-34.75191, -56.24424),
    const LatLng(-34.75175, -56.24492),
    const LatLng(-34.75159, -56.24568),
    const LatLng(-34.75134, -56.24681),
    const LatLng(-34.75121, -56.24735),
    const LatLng(-34.75098, -56.24838),
    const LatLng(-34.75098, -56.24838),
    const LatLng(-34.75095, -56.24853),
    const LatLng(-34.75093, -56.24897),
    const LatLng(-34.75093, -56.24905),
    const LatLng(-34.75095, -56.25),
    const LatLng(-34.75098, -56.2524),
    const LatLng(-34.75096, -56.25253),
    const LatLng(-34.74988, -56.25219),
    const LatLng(-34.74996, -56.25262),
    const LatLng(-34.75001, -56.25278),
    const LatLng(-34.75005, -56.25286),
    const LatLng(-34.75014, -56.25292),
    const LatLng(-34.75025, -56.25296),
    const LatLng(-34.7504, -56.25296),
    const LatLng(-34.75053, -56.25295),
    const LatLng(-34.75056, -56.25295),
    const LatLng(-34.75089, -56.2529),
    const LatLng(-34.75096, -56.25253),
    const LatLng(-34.75098, -56.2524),
    const LatLng(-34.75095, -56.25),
    const LatLng(-34.75093, -56.24905),
    const LatLng(-34.75093, -56.24897),
    const LatLng(-34.75095, -56.24853),
    const LatLng(-34.75121, -56.24735),
    const LatLng(-34.75134, -56.24681),
    const LatLng(-34.75159, -56.24568),
    const LatLng(-34.75175, -56.24492),
    const LatLng(-34.75191, -56.24424),
    const LatLng(-34.75232, -56.24237),
    const LatLng(-34.75034, -56.24187),
    const LatLng(-34.75026, -56.24185),
    const LatLng(-34.74992, -56.24177),
    const LatLng(-34.7493, -56.24163),
    const LatLng(-34.7486, -56.24145),
    const LatLng(-34.74793, -56.24128),
    const LatLng(-34.74733, -56.24113),
    const LatLng(-34.74657, -56.24095),
    const LatLng(-34.74504, -56.24056),
    const LatLng(-34.74493, -56.24116),
    const LatLng(-34.74493, -56.24116),
    const LatLng(-34.74427, -56.24488),
    const LatLng(-34.74426, -56.24493),
    const LatLng(-34.74424, -56.24494),
    const LatLng(-34.74419, -56.24494),
    const LatLng(-34.74366, -56.24477),
    const LatLng(-34.74419, -56.24494),
    const LatLng(-34.74424, -56.24494),
    const LatLng(-34.74426, -56.24493),
    const LatLng(-34.74427, -56.24488),
    const LatLng(-34.74504, -56.24056),
    const LatLng(-34.74482, -56.2405),
    const LatLng(-34.74412, -56.24032),
    const LatLng(-34.74354, -56.24018),
    const LatLng(-34.7427, -56.23997),
    const LatLng(-34.74158, -56.23969),
    const LatLng(-34.73965, -56.2392),
    const LatLng(-34.73877, -56.23898),
    const LatLng(-34.73873, -56.23897),
    const LatLng(-34.73746, -56.23864),
    const LatLng(-34.73825, -56.23519),
    const LatLng(-34.73772, -56.23515),
    const LatLng(-34.73698, -56.23511),
    const LatLng(-34.73642, -56.23507),
    const LatLng(-34.73534, -56.23499),
    const LatLng(-34.7343, -56.23498),
    const LatLng(-34.7343, -56.23382),
    const LatLng(-34.73432, -56.23257),
    const LatLng(-34.73432, -56.23137),
    const LatLng(-34.73432, -56.23012),
    const LatLng(-34.73432, -56.22951),
    const LatLng(-34.73432, -56.22951),
    const LatLng(-34.73432, -56.22881),
    const LatLng(-34.73432, -56.22803),
    const LatLng(-34.73432, -56.22757),
    const LatLng(-34.73432, -56.2267),
    const LatLng(-34.73433, -56.22562),
    const LatLng(-34.73433, -56.22453),
    const LatLng(-34.73432, -56.22375),
    const LatLng(-34.73327, -56.22375),
    const LatLng(-34.7322, -56.22375),
    const LatLng(-34.73105, -56.22375),
    const LatLng(-34.73002, -56.22376),
    const LatLng(-34.72913, -56.22376),
    const LatLng(-34.7282, -56.22376),
    const LatLng(-34.72726, -56.22375),
    const LatLng(-34.72632, -56.22378),
    const LatLng(-34.72539, -56.22376),
    const LatLng(-34.72488, -56.22376),
    const LatLng(-34.72488, -56.22376),
    const LatLng(-34.72448, -56.22376),
    const LatLng(-34.7236, -56.22375),
    const LatLng(-34.72171, -56.22375),
    const LatLng(-34.7217, -56.22449),
    const LatLng(-34.7217, -56.22525),
    const LatLng(-34.72171, -56.22753),
    const LatLng(-34.72094, -56.22753),
    const LatLng(-34.7198, -56.22753),
    const LatLng(-34.71922, -56.22753),
    const LatLng(-34.71877, -56.22752),
    const LatLng(-34.71855, -56.22756),
    const LatLng(-34.71847, -56.22761),
    const LatLng(-34.71842, -56.22771),
    const LatLng(-34.71839, -56.22784),
    const LatLng(-34.71839, -56.22799),
    const LatLng(-34.71839, -56.22803),
    const LatLng(-34.71839, -56.22804),
    const LatLng(-34.71731, -56.22803),
    const LatLng(-34.7168, -56.22804),
    const LatLng(-34.71587, -56.22805),
    const LatLng(-34.71447, -56.22805),
    const LatLng(-34.71362, -56.22806),
    const LatLng(-34.71263, -56.22803),
    const LatLng(-34.71254, -56.22803),
    const LatLng(-34.71236, -56.22803),
    const LatLng(-34.71152, -56.22804),
    const LatLng(-34.71046, -56.22804),
    const LatLng(-34.71048, -56.22887),
    const LatLng(-34.71047, -56.22921),
    const LatLng(-34.71047, -56.22921),
    const LatLng(-34.71046, -56.22965),
    const LatLng(-34.71152, -56.22964),
    const LatLng(-34.71257, -56.22965),
    const LatLng(-34.71388, -56.22965),
    const LatLng(-34.71446, -56.22965),
    const LatLng(-34.71582, -56.22971),
    const LatLng(-34.7168, -56.22971),
    const LatLng(-34.71729, -56.2297),
    const LatLng(-34.71772, -56.22993),
    const LatLng(-34.71778, -56.22993),
    const LatLng(-34.71782, -56.22991),
    const LatLng(-34.71792, -56.22981),
    const LatLng(-34.71828, -56.22899),
    const LatLng(-34.71839, -56.229),
    const LatLng(-34.71839, -56.22914),
    const LatLng(-34.71839, -56.22974),
    const LatLng(-34.71839, -56.23058),
    const LatLng(-34.71838, -56.23076),
    const LatLng(-34.71834, -56.23106),
    const LatLng(-34.7183, -56.2312),
    const LatLng(-34.71832, -56.23133),
    const LatLng(-34.7184, -56.23141),
    const LatLng(-34.71921, -56.23142),
    const LatLng(-34.72005, -56.23143),
    const LatLng(-34.72092, -56.23143),
    const LatLng(-34.72171, -56.23145),
    const LatLng(-34.72301, -56.23149),
    const LatLng(-34.72392, -56.23151),
    const LatLng(-34.72438, -56.23153),
    const LatLng(-34.72552, -56.2315),
    const LatLng(-34.72642, -56.23147),
    const LatLng(-34.72663, -56.23147),
    const LatLng(-34.72754, -56.23144),
    const LatLng(-34.72827, -56.23143),
    const LatLng(-34.72891, -56.23141),
    const LatLng(-34.72955, -56.23139),
    const LatLng(-34.73031, -56.23137),
    const LatLng(-34.73117, -56.23135),
    const LatLng(-34.73219, -56.23136),
    const LatLng(-34.73222, -56.23261),
    const LatLng(-34.73219, -56.23381),
    const LatLng(-34.73221, -56.23484),
    const LatLng(-34.73214, -56.23484)
  ];

  @override
  void initState() {
    super.initState();

    // declared for loop for various locations
    for (int i = 0; i < latLenMarkers.length; i++) {
      _markers.add(
          // added markers
          Marker(
        markerId: MarkerId(i.toString()),
        position: latLenMarkers[i],
        infoWindow: InfoWindow(
          title: 'MARKER',
          snippet: 'id: ${i.toString()}',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(
        polylineId: const PolylineId('1'),
        points: original,
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
