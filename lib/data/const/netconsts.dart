// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

class NetConts {
  static const int REFRESH_TIME = 30;
  static const String API_URL = "https://api.karaiguazu.com/";
  static const String API_BASIC_USER = "dev";
  static const String API_BASIC_PASS = "dev";

  static const String API_URL_TIPO_RESIDUO = "${API_URL}tiporesiduo/";
  static const String API_URL_PUNTO_DE_RECOLECCION = "${API_URL}puntodr/";
  static const String API_URL_USUARIO_ROL = "${API_URL}rol/";
  static const String API_URL_VEHICULO = "${API_URL}vehiculo/";

  static const String API_URL_USUARIO = "${API_URL}usuario/";

  String getGoogleAPIKey() {
    const String googleMapsApiKey = kIsWeb
        ? "AIzaSyC-ojOj6y2NTYM0TlP2-MSw4QURB9bUUUg"
        : "AIzaSyDMvkrYjb61DJSifnEeyweDn41tEi_0B2U";
    return googleMapsApiKey;
  }

  String getBasicAuth() {
    return 'Basic ${base64Encode(utf8.encode('$API_BASIC_USER:$API_BASIC_PASS'))}';
  }
}
