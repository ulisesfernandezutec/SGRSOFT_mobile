// formluario para agregar un nuevo tipo de residuo

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/usuario/editar/editar_bloc.dart';
import 'package:sgrsoft/domain/blocs/usuario/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/enums/usuario_estado.dart';
import 'package:sgrsoft/domain/enums/usuario_tipo.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/services/encriptar.dart';
import 'package:sgrsoft/ui/const/forms.dart';
import 'package:sgrsoft/ui/widgets/modal/head.dart';

class EditarUsuarioScreen extends StatefulWidget {
  final int id;
  const EditarUsuarioScreen({Key? key, required this.id}) : super(key: key);

  @override
  EditarUsuarioScreenState createState() => EditarUsuarioScreenState();
}

class EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passController2 = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final telefonoController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordFocusNode2 = FocusNode();
  final FocusNode _nombreFocusNode = FocusNode();
  final FocusNode _apellidoFocusNode = FocusNode();
  final FocusNode _telefonoFocusNode = FocusNode();

  final encript = Encriptrar();

  String password = "";
  String rol = "";
  String estado = "";

  bool showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    passController2.dispose();
    nombreController.dispose();
    apellidoController.dispose();
    telefonoController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordFocusNode2.dispose();
    _nombreFocusNode.dispose();
    _apellidoFocusNode.dispose();
    _telefonoFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<EditarUsuarioBloc>(context)
        .add(EditarUsuarioEventLoad(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            EditarUsuarioBloc()..add(EditarUsuarioEventLoad(widget.id)),
        child: BlocBuilder<EditarUsuarioBloc, EditarUsuarioState>(
            builder: (context, state) {
          if (state is EditarUsuarioError) {
            return Center(
                child: Text(
              state.error,
              style: const TextStyle(color: Colors.red),
            ));
          } else if (state is EditarUsuarioSaved) {
            Navigator.of(context).pop();
            return const Text('Guardado');
          } else if (state is EditarUsuarioSuccess) {
            nombreController.text = state.usuario.nombre!;
            apellidoController.text = state.usuario.apellido!;
            telefonoController.text = state.usuario.telefono!;
            emailController.text = state.usuario.email!;
            rol = state.usuario.rol!.nombre;
            state.usuario.estado ??= UsuarioEstadoOptions.activo.value;
            estado = state.usuario.estado!;

            return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                            autofocus: true,
                            focusNode: _nombreFocusNode,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: ((value) =>
                                value!.isEmpty ? "Ingrese su nombre" : null),
                            controller: nombreController,
                            decoration: const InputDecoration(
                              labelText: 'Nombre',
                              hintText: 'Ingrese su nombre',
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              state.usuario.nombre = value;
                              BlocProvider.of<EditarUsuarioBloc>(context).add(
                                  EditarUsuarioEventUpdate(
                                      usuario: state.usuario,
                                      showPassword: showPassword));
                            })),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextFormField(
                            autofocus: true,
                            focusNode: _apellidoFocusNode,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: ((value) =>
                                value!.isEmpty ? "Ingrese su apellido" : null),
                            controller: apellidoController,
                            decoration: const InputDecoration(
                              labelText: 'Apellido',
                              hintText: 'Ingrese su apellido',
                              prefixIcon: Icon(Icons.person_add_alt_1_outlined),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              state.usuario.apellido = value;
                              BlocProvider.of<EditarUsuarioBloc>(context).add(
                                  EditarUsuarioEventUpdate(
                                      usuario: state.usuario,
                                      showPassword: showPassword));
                            })),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextFormField(
                            autofocus: true,
                            focusNode: _telefonoFocusNode,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: ((value) =>
                                value!.isEmpty ? "Ingrese su teléfono" : null),
                            controller: telefonoController,
                            decoration: const InputDecoration(
                              labelText: 'Teléfono',
                              hintText: 'Ingrese su teléfono',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              state.usuario.telefono = value;
                              BlocProvider.of<EditarUsuarioBloc>(context).add(
                                  EditarUsuarioEventUpdate(
                                      usuario: state.usuario,
                                      showPassword: showPassword));
                            })),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            border: OutlineInputBorder(
                              // borderSide:
                              //     BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                            // fillColor: Colors.blueAccent,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Seleccione el tipo de usuario";
                            } else if (value == "") {
                              return "Seleccione el tipo de usuario";
                            } else {
                              return null;
                            }
                          },
                          value: rol,
                          hint: const Text("Seleccione el tipo de usuario"),
                          items: UsuarioTipoOptions.values
                              .map((o) => DropdownMenuItem(
                                  value: o.value, child: Text(o.value)))
                              .toList(),
                          onChanged: (value) {
                            state.usuario.rol = Rol(0, value ?? '');
                            BlocProvider.of<EditarUsuarioBloc>(context).add(
                                EditarUsuarioEventUpdate(
                                    usuario: state.usuario,
                                    showPassword: showPassword));
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            border: OutlineInputBorder(
                              // borderSide:
                              //     BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                            // fillColor: Colors.blueAccent,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Seleccione un estado";
                            } else if (value == "") {
                              return "Seleccione un estado";
                            } else {
                              return null;
                            }
                          },
                          value: estado,
                          hint: const Text("Seleccione el estado"),
                          items: UsuarioEstadoOptions.values
                              .map((o) => DropdownMenuItem(
                                  value: o.value, child: Text(o.value)))
                              .toList(),
                          onChanged: (value) {
                            state.usuario.estado = value;
                            BlocProvider.of<EditarUsuarioBloc>(context).add(
                                EditarUsuarioEventUpdate(
                                    usuario: state.usuario,
                                    showPassword: showPassword));
                          }),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextFormField(
                            // autofocus: true,
                            focusNode: _emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                EmailValidator.validate(value!)
                                    ? null
                                    : "Ingrese un correo valido",
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Correo',
                              hintText: 'Ingrese su correo',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              state.usuario.email = value;
                              BlocProvider.of<EditarUsuarioBloc>(context).add(
                                  EditarUsuarioEventUpdate(
                                      usuario: state.usuario,
                                      showPassword: showPassword));
                            })),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: const Text(
                        "Cambiar contraseña",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    showPassword
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: TextFormField(
                                focusNode: _passwordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                controller: passController,
                                obscureText: true,
                                validator: ((value) {
                                  if (value!.isEmpty) {
                                    return "Ingrese la contraseña";
                                  } else if (passController.value !=
                                      passController2.value) {
                                    return "Las contraseñas no coinciden";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.key_outlined),
                                  border: OutlineInputBorder(),
                                  labelText: 'Contraseña',
                                  hintText: 'Ingrese una contraseña',
                                )
                                // onFieldSubmitted: (String value) async {
                                //   login(emailController.text, passController.text);
                                // },
                                ),
                          )
                        : Container(),
                    showPassword
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: TextFormField(
                                focusNode: _passwordFocusNode2,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                controller: passController2,
                                obscureText: true,
                                validator: ((value) {
                                  if (value!.isEmpty) {
                                    return "Repita la contraseña";
                                  } else if (passController.value !=
                                      passController2.value) {
                                    return "Las contraseñas no coinciden";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.key_outlined),
                                  border: OutlineInputBorder(),
                                  labelText: 'Repita Contraseña',
                                  hintText: 'Repita la contraseña',
                                )
                                // onFieldSubmitted: (String value) async {
                                //   login(emailController.text, passController.text);
                                // },
                                ),
                          )
                        : Container(),
                    const Divider(),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                                icon: const Icon(Icons.close,
                                    color: Colors.white),
                                onPressed: () => {Navigator.of(context).pop()},
                                label: const Text("Salir",
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  padding: FormConst.buttonPadding,
                                  backgroundColor: Colors.grey,
                                )),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.save, color: Colors.white),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Usuario usuario = state.usuario;
                                  usuario.nombre = nombreController.text;
                                  usuario.apellido = apellidoController.text;
                                  usuario.telefono = telefonoController.text;
                                  usuario.email = emailController.text;
                                  // usuario.rol = Rol(0, rol);
                                  if (showPassword) {
                                    usuario.password =
                                        encript.encript(passController.text);
                                  } else {
                                    usuario.password = null;
                                  }

                                  BlocProvider.of<EditarUsuarioBloc>(context)
                                      .add(EditarUsuarioEventSave(
                                          usuario: usuario));
                                }
                              },
                              label: const Text("Guardar",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                padding: FormConst.buttonPadding,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ))
                  ]),
                ));
          } else {
            return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor));
          }
        }));
  }
}
