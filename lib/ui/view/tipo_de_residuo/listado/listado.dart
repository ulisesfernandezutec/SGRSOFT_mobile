import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/ui/view/tipo_de_residuo/nuevo/agregar.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../detalle/detalle.dart';

// crear listado de tipo de residuo
List<TipoDeResiduo> listaTipoDeResiduo = [
  TipoDeResiduo(1, 'Papel'),
  TipoDeResiduo(2, 'Vidrio'),
  TipoDeResiduo(3, 'Plastico'),
  TipoDeResiduo(4, 'Metal'),
  TipoDeResiduo(5, 'Carton'),
  TipoDeResiduo(6, 'Textil'),
  TipoDeResiduo(7, 'Organico'),
  TipoDeResiduo(8, 'Electronico'),
  TipoDeResiduo(9, 'Otros'),
];

class ListadoTipoResiduos extends StatelessWidget {
  const ListadoTipoResiduos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      // boton para agregar tipo de residuo
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgregarTipoResiduo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: listaTipoDeResiduo.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listaTipoDeResiduo[index].nombre),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleTipoResiduo(
                    tipoResiduo: listaTipoDeResiduo[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
