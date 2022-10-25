import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/tipos_residuos/listado/listado_bloc.dart';
import 'package:sgrsoft/ui/view/tipo_de_residuo/nuevo/agregar.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../detalle/detalle.dart';

class ListadoTipoResiduos extends StatelessWidget {
  const ListadoTipoResiduos({Key? key}) : super(key: key);

  static const routeName = '/tipos_de_residuos/listado';

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
      body: BlocBuilder<ListadoTipoDeResiduosBloc, ListadoTiposDeResiduosState>(
          builder: (context, state) {
        return ListView.builder(
          itemCount: state.tiposDeResiduos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(state.tiposDeResiduos[index].nombre),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalleTipoResiduo(
                      tipoResiduo: state.tiposDeResiduos[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
