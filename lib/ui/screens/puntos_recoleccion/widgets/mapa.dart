import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class MapaPuntosRecoleccionWidgets extends StatelessWidget {
  MapaPuntosRecoleccionWidgets({super.key});
  final controller = MapController(
    location: const LatLng(0, 0),
    zoom: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}
