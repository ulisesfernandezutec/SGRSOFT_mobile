import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/usuario.dart';
import 'package:sgrsoft/domain/blocs/usuario/detalle/detalle_bloc.dart';
import 'package:sgrsoft/ui/const/forms.dart';
import 'package:sgrsoft/ui/view/usuario/editar/editar.dart';
import 'package:sgrsoft/ui/widgets/modal/delete_confirm_modal.dart';
import 'package:sgrsoft/ui/widgets/modal/head.dart';

// import '../editar/editar.dart';

class DetalleUsuarioScreen extends StatefulWidget {
  final int id;

  const DetalleUsuarioScreen({Key? key, required this.id}) : super(key: key);

  @override
  DetalleUsuarioScreenState createState() => DetalleUsuarioScreenState();
}

class DetalleUsuarioScreenState extends State<DetalleUsuarioScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocProvider(
                create: (BuildContext context) => DetalleUsuarioBloc()
                  ..add(LoadDetalleUsuarioEvent(widget.id)),
                child: BlocBuilder<DetalleUsuarioBloc, DetalleUsuarioState>(
                    builder: (context, state) {
                  if (state is DetalleUsuarioError) {
                    return Column(children: [
                      Text('No se pudo cargar el usuario',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.red)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Salir'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<DetalleUsuarioBloc>(context)
                                  .add(LoadDetalleUsuarioEvent(widget.id));
                            },
                            child: const Text('Reintentar'),
                          ),
                        ],
                      )
                    ]);
                  } else if (state is DetalleUsuarioLoaded) {
                    String nombre = state.usuario.nombre ?? 'Sin Nombre';
                    String apellido = state.usuario.apellido ?? 'Sin Apellido';
                    String nombreCompleto = '$nombre $apellido';
                    String telefono = state.usuario.telefono ?? 'Sin teléfono';
                    String email = state.usuario.email ?? 'Sin email';
                    String direccion =
                        state.usuario.direccion ?? 'Sin dirección';
                    String tipo = state.usuario.rol?.nombre ?? 'Sin rol';
                    String estado = state.usuario.estado ?? 'Sin estado';

                    return Column(mainAxisSize: MainAxisSize.max, children: [
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Text(
                                "Nombre completo: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                softWrap: true,
                              ),
                              Text(nombreCompleto),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Text(
                                "Teléfono: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(telefono),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Text(
                                "Email: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(email),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Text(
                                "Dirección: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(direccion),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Text(
                                "Tipo: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(tipo),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Text(
                                "Estado: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(estado),
                            ],
                          )),
                      const Spacer(),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () =>
                                      {Navigator.of(context).pop()},
                                  label: const Text("Salir",
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    padding: FormConst.buttonPadding,
                                    backgroundColor: Colors.grey,
                                  )),
                              ElevatedButton.icon(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                  onPressed: () async {
                                    bool? borrar = await showDialog<bool>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: const AppHeadModal(
                                                  title: "Eliminar Usuario"),
                                              titlePadding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.zero,
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              content: Container(
                                                  width: double.infinity,
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxHeight: 200,
                                                          maxWidth: 350),
                                                  child:
                                                      const DeleteConfirmModal()));
                                        });
                                    if (borrar != null && borrar) {
                                      GetIt locator = GetIt.instance;
                                      UsuarioRepository usuarioRepository =
                                          locator<UsuarioRepository>();
                                      await usuarioRepository
                                          .delete(state.usuario);
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  label: const Text("Eliminar",
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    padding: FormConst.buttonPadding,
                                    backgroundColor: Colors.red,
                                  )),
                              ElevatedButton.icon(
                                icon:
                                    const Icon(Icons.edit, color: Colors.white),
                                onPressed: () async {
                                  await showDialog<bool>(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: const AppHeadModal(
                                                title: "Editar Usuario"),
                                            titlePadding: EdgeInsets.zero,
                                            contentPadding: EdgeInsets.zero,
                                            insetPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 0),
                                            content: Container(
                                                width: double.infinity,
                                                margin: const EdgeInsets.all(0),
                                                constraints: BoxConstraints(
                                                    maxHeight: kIsWeb
                                                        ? 600
                                                        : MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    maxWidth: 700),
                                                child: EditarUsuarioScreen(
                                                    id: widget.id)));
                                      });
                                  setState(() {});
                                  // // ignore: use_build_context_synchronously
                                  // BlocProvider.of<DetalleUsuarioBloc>(context)
                                  //     .add(LoadDetalleUsuarioEvent(widget.id));
                                },
                                label: const Text("Editar",
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  padding: FormConst.buttonPadding,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ))
                    ]);
                  } else {
                    return const Center(child: Text('Error'));
                  }
                }))));

    //     Column(
    //       children: [
    //         const Text("sin matricula"),
    //         ElevatedButton(
    //           onPressed: () async {
    //             // usuario = await Navigator.push(
    //             //     context,
    //             //     MaterialPageRoute(
    //             //       builder: (context) => EditarUsuarioScreen(
    //             //         usuario: usuario,
    //             //       ),
    //             //     ));
    //             // setState(() {
    //             //   usuario = usuario;
    //             // });
    //           },
    //           child: const Text('Editar'),
    //         ),
    //         // ElevatedButton(
    //         //   onPressed: () {
    //         //     // Navigator.push(
    //         //     //   context,
    //         //     //   MaterialPageRoute(
    //         //     //     builder: (context) => EliminarUsuario(
    //         //     //       usuario: usuario,
    //         //     //     ),
    //         //     //   ),
    //         //     // );
    //         //   },
    //         //   child: const Text('Eliminar'),
    //         // ),
    //       ],
    //     ),
    //   ));
    // }
  }
}
