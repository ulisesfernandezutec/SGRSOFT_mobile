import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class ImageStore {
  final Widget logo =
      const Image(image: AssetImage('assets/images/logo.png'), height: 50);

  final Widget logoLogin = const Image(
      image: AssetImage('assets/images/logo.png'), width: 167, height: 58);

  static const markerIcon = BitmapDescriptor.defaultMarker;

  static Future<Uint8List> getBytesFromAsset(
      String path, int width, BuildContext context) async {
    // double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double pixelRatio = ui.window.devicePixelRatio;
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: pixelRatio.round() * 30);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
