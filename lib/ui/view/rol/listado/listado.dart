import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/rol/listado/listado_bloc.dart';
import 'package:sgrsoft/ui/view/rol/nuevo/agregar.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

import '../detalle/detalle.dart';

class ListadoRolScreen extends StatefulWidget {
  const ListadoRolScreen({Key? key}) : super(key: key);

  static const routeName = '/rol/listado';

  @override
  State<StatefulWidget> createState() {
    return ListadoRolScreenState();
  }
}

class ListadoRolScreenState extends State<ListadoRolScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListadoRolBloc>(context).add(LoadListadoRolEvent());
  }

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
              builder: (context) => const AgregarRolScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ListadoRolBloc, ListadoRolState>(
          builder: (context, state) {
        if (state is ListadoInitialRolState) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor));
        } else {
          return ListView.builder(
            itemCount: state.rol.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.rol[index].nombre),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleRolScreen(
                        rol: state.rol[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      }),
    );
  }
}
