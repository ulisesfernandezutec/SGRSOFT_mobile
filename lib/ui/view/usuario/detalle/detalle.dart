import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../editar/editar.dart';

class DetalleVehiculoScreen extends StatefulWidget {
  final Vehiculo vehiculo;

  const DetalleVehiculoScreen({Key? key, required this.vehiculo})
      : super(key: key);

  @override
  DetalleVehiculoScreenState createState() => DetalleVehiculoScreenState();
}

class DetalleVehiculoScreenState extends State<DetalleVehiculoScreen> {
  late Vehiculo vehiculo;

  @override
  void initState() {
    super.initState();
    setState(() {
      vehiculo = widget.vehiculo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Text(vehiculo.matricula ?? "sin matricula"),
          ElevatedButton(
            onPressed: () async {
              vehiculo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarVehiculoScreen(
                      vehiculo: vehiculo,
                    ),
                  ));
              setState(() {
                vehiculo = vehiculo;
              });
            },
            child: const Text('Editar'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (context) => EliminarVehiculo(
          //     //       vehiculo: vehiculo,
          //     //     ),
          //     //   ),
          //     // );
          //   },
          //   child: const Text('Eliminar'),
          // ),
        ],
      ),
    );
  }
}
