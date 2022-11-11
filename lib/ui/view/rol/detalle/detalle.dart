import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../editar/editar.dart';

class DetalleRolScreen extends StatefulWidget {
  final Rol rol;

  const DetalleRolScreen({Key? key, required this.rol}) : super(key: key);

  @override
  DetalleRolScreenState createState() => DetalleRolScreenState();
}

class DetalleRolScreenState extends State<DetalleRolScreen> {
  late Rol rol;

  @override
  void initState() {
    super.initState();
    setState(() {
      rol = widget.rol;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Text(rol.nombre),
          ElevatedButton(
            onPressed: () async {
              rol = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarRolScreen(
                      rol: rol,
                    ),
                  ));
              setState(() {
                rol = rol;
              });
            },
            child: const Text('Editar'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (context) => EliminarRol(
          //     //       rol: rol,
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
