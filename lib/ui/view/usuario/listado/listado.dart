import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/usuario/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/ui/view/usuario/nuevo/agregar.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';
import 'package:sgrsoft/ui/widgets/modal/head.dart';
import 'package:data_table_2/data_table_2.dart';
// import '../detalle/detalle.dart';

class ListadoUsuarioScreen extends StatefulWidget {
  const ListadoUsuarioScreen({Key? key}) : super(key: key);

  static const routeName = '/usuario/listado';

  @override
  State<StatefulWidget> createState() {
    return ListadoUsuarioScreenState();
  }
}

class ListadoUsuarioScreenState extends State<ListadoUsuarioScreen> {
  final ScrollController _controller = ScrollController();
  // late List<Usuario> _usuarios;
  // bool _sortAscending = true;
  // int? _sortColumnIndex;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListadoUsuarioBloc>(context).add(ListadoUsuarioLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const AppHeadModal(title: "Nuevo Usuario"),
                    titlePadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 0),
                    content: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(0),
                        constraints: BoxConstraints(
                            maxHeight: kIsWeb
                                ? 600
                                : MediaQuery.of(context).size.height,
                            maxWidth: 700),
                        child: const AgregarUsuarioScreen()));
              });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ListadoUsuarioBloc, ListadoUsuarioState>(
          builder: (context, state) {
        if (state is ListadoUsuarioLoading) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor));
        } else if (state is ListadoUsuarioSuccess) {
          return Center(
              heightFactor: 1,
              child: Card(
                  elevation: 3,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      child: Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              // maxHeight:
                              //     kIsWeb ? 600 : MediaQuery.of(context).size.height,
                              maxWidth: 900),
                          child: DataTable2(columns: const [
                            DataColumn2(
                                label: Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn2(
                                label: Text(
                              "Nombre",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn2(
                                label: Text(
                              "Apellido",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn2(
                                fixedWidth: 120,
                                label: Text(
                                  "Tipo",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                          ], rows: [
                            for (var usuario in state.usuarios)
                              DataRow(
                                key: ValueKey<int?>(usuario.id),
                                cells: [
                                  DataCell(Text(usuario.email!),
                                      onTap: () =>
                                          {log(usuario.email!.toString())}),
                                  DataCell(Text(usuario.nombre!)),
                                  DataCell(Text(usuario.apellido!)),
                                  DataCell(Text(usuario.rol!.nombre)),
                                ],
                                // onSelectChanged: (value) => {log(usuario.email!)},
                                // onLongPress: () =>
                                //     {log(usuario.id.toString())}
                              )
                          ])))));
        } else {
          return const Center(child: Text("No hay usuarios"));
        }
      }),
    );
  }
}
