import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../editar/editar.dart';

class DetalleTipoResiduo extends StatelessWidget {
  final TipoDeResiduo tipoResiduo;

  const DetalleTipoResiduo({Key? key, required this.tipoResiduo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Text(tipoResiduo.nombre),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => EditarTipoResiduo(
                    tipoResiduo: tipoResiduo,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Editar'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (context) => EliminarTipoResiduo(
          //     //       tipoResiduo: tipoResiduo,
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
