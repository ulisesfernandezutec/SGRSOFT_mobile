import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/drawer.dart';
import 'package:sgrsoft/ui/widgets/menu_inferior.dart';

class MapaPuntosRecoleccion extends StatefulWidget {
  const MapaPuntosRecoleccion({super.key});
  static const routeName = '/mapa';

  @override
  // ignore: library_private_types_in_public_api
  _MapaPuntosRecoleccionState createState() => _MapaPuntosRecoleccionState();
}

class _MapaPuntosRecoleccionState extends State<MapaPuntosRecoleccion> {
  final controller = MapController(
    location: const LatLng(0, 0),
    zoom: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: appDrawer(context),
        body: SafeArea(
          child: Column(children: <Widget>[
            Center(
              child: Card(
                  child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).drawerTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search,
                        color: Theme.of(context).colorScheme.primary),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar',
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.sort,
                          color: Theme.of(context).colorScheme.primary),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0.5, 0),
                    ),
                    IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.filter_list,
                            color: Theme.of(context).colorScheme.primary),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0.5, 0)),
                  ],
                ),
              )),
            ),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MapLayout(
                      controller: controller,
                      builder: (context, transformer) {
                        return TileLayer(
                          builder: (context, x, y, z) {
                            final tilesInZoom = pow(2.0, z).floor();

                            while (x < 0) {
                              x += tilesInZoom;
                            }
                            while (y < 0) {
                              y += tilesInZoom;
                            }

                            x %= tilesInZoom;
                            y %= tilesInZoom;

                            //Google Maps
                            final url =
                                'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                            return CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      },
                    ))),
          ]),
        ),
        persistentFooterButtons: menuInferior(context));
  }
}
