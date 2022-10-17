// pagina de demostracion de parametros de entrada
import 'package:flutter/material.dart';

class DemoParams extends StatefulWidget {
  const DemoParams({super.key});

  static const routeName = '/demo/params';

  @override
  DemoParamsState createState() => DemoParamsState();
}

class DemoParamsState extends State<DemoParams> {
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
