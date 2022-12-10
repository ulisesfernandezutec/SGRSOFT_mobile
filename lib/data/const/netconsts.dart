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

  static const String GOOGLE_URL_DIRECTIONS =
      "https://maps.googleapis.com/maps/api/directions/json";
  static const String GOOGLE_URL_GEOCODING =
      "https://maps.googleapis.com/maps/api/geocode/json";
  static const String GOOGLE_URL_PLACES =
      "https://maps.googleapis.com/maps/api/place/findplacefromtext/json";

  // Variables para Azure Cloud
  static const String AZURE_SUBSCRIPTION_KEY =
      "UToIPMAkiSZd0hePC8WhUGK-d5HnWDheSB0H14jAkxU";
  static const String AZURE_BEST_ORDER =
      "https://atlas.microsoft.com/route/directions/json?subscription-key=$AZURE_SUBSCRIPTION_KEY&api-version=1.0&travelMode=car&traffic=true&computeTravelTimeFor=all&computeBestOrder=true&routeType=shortest&RouteRepresentationForBestOrder=polyline&language=es-419&query=";

  static String getGoogleAPIKey() {
    const String googleMapsApiKey = kIsWeb
        ? "AIzaSyC-ojOj6y2NTYM0TlP2-MSw4QURB9bUUUg"
        : "AIzaSyDMvkrYjb61DJSifnEeyweDn41tEi_0B2U";
    return googleMapsApiKey;
  }

  String getBasicAuth() {
    return 'Basic ${base64Encode(utf8.encode('$API_BASIC_USER:$API_BASIC_PASS'))}';
  }

  // Authentification API
  static const String API_URL_AUTH_LOGIN = "$API_URL/login";
  static const String API_JWT_REFRESH = "${API_URL}tkn/";
  static const String API_JWT_VERIFY = "${API_URL}tkn/";
  static const String API_GOOGLE_CHECK_TOKEN = "${API_URL}glogin/";
}
