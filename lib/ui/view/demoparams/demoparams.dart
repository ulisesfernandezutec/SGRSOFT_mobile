// pagina de demostracion de parametros de entrada
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/google_directions/google_direction.dart';

class DemoParams extends StatefulWidget {
  const DemoParams({super.key});

  static const routeName = '/demo/params';

  @override
  DemoParamsState createState() => DemoParamsState();
}

class DemoParamsState extends State<DemoParams> {
  void testDio() {
    Dio dio = Dio();
    dio
        .get(
            'https://maps.googleapis.com/maps/api/directions/json?origin=las+piedras+canelones+juan+ortiz+esquina+danton&destination=utec+durazno&language=es&key=AIzaSyC-ojOj6y2NTYM0TlP2-MSw4QURB9bUUUg&waypoints=plaza+independecia+montevideo|intendencia+montevideo')
        .then((value) {
      log("value.data: ${value.data}");
      GoogleDirection googleDirection = GoogleDirection.fromJson(value.data);
      log("googleDirection.toString(): ${googleDirection.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DemoParamsArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.titulo),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              args.subtitulo,
            ),
            Text(
              args.id.toString(),
            ),
            ElevatedButton(onPressed: testDio, child: const Text('Test Dio'))
          ],
        ),
      ),
    );
  }
}

class DemoParamsArguments {
  String titulo;
  String subtitulo;
  int id;
  DemoParamsArguments(
      {required this.titulo, required this.subtitulo, required this.id});
}
