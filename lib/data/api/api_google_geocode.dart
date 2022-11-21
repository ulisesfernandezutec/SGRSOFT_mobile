import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:sgrsoft/data/const/netconsts.dart';

class ApiGoogleGeoCode {
  Future<LatLng?> getLatLngFromAddress(String address) async {
    try {
      final Dio dio = Dio();
      address = address.replaceAll(' ', '+');
      var request = await dio.get(
          'https://maps.googleapis.com/maps/api/geocode/json?address=$address&region=UY&key=${NetConts.getGoogleAPIKey()}');
      GeocodingResponse responseDireccions =
          GeocodingResponse.fromJson(request.data);
      if (responseDireccions.results.isNotEmpty) {
        final location = responseDireccions.results.first.geometry.location;
        return LatLng(location.lat, location.lng);
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }
}
