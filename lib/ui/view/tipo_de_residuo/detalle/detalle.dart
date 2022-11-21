import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../editar/editar.dart';

class DetalleTipoResiduo extends StatefulWidget {
  final TipoDeResiduo tipoResiduo;

  const DetalleTipoResiduo({Key? key, required this.tipoResiduo})
      : super(key: key);

  @override
  DetalleTipoResiduoState createState() => DetalleTipoResiduoState();
}

class DetalleTipoResiduoState extends State<DetalleTipoResiduo> {
  late TipoDeResiduo tipoResiduo;

  @override
  void initState() {
    super.initState();
    setState(() {
      tipoResiduo = widget.tipoResiduo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Text(tipoResiduo.nombre),
          ElevatedButton(
            onPressed: () async {
              tipoResiduo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarTipoResiduo(
                      tipoResiduo: tipoResiduo,
                    ),
                  ));
              setState(() {
                tipoResiduo = tipoResiduo;
              });
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
