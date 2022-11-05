// ignore_for_file: constant_identifier_names

import 'dart:convert';

class NetConts {
  static const int REFRESH_TIME = 30;
  static const String API_URL = "https://api.karaiguazu.com/";
  static const String API_BASIC_USER = "dev";
  static const String API_BASIC_PASS = "dev";

  static const String API_URL_TIPO_RESIDUO = "${API_URL}tiporesiduo/";
  static const String API_URL_PUNTO_DE_RECOLECCION = "${API_URL}puntodr/";

  String getBasicAuth() {
    return 'Basic ${base64Encode(utf8.encode('$API_BASIC_USER:$API_BASIC_PASS'))}';
  }
}
