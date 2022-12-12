// formluario para agregar un nuevo tipo de residuo

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/usuario/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/enums/usuario_tipo.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/services/encriptar.dart';

class AgregarUsuarioScreen extends StatefulWidget {
  const AgregarUsuarioScreen({Key? key}) : super(key: key);

  @override
  AgregarUsuarioScreenState createState() => AgregarUsuarioScreenState();
}

class AgregarUsuarioScreenState extends State<AgregarUsuarioScreen> {
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
  Widget build(BuildContext context) {
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
                )),
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
                )),
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
                )),
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
                  // value: "",
                  hint: const Text("Seleccione el tipo de usuario"),
                  items: UsuarioTipoOptions.values
                      .map((o) => DropdownMenuItem(
                          value: o.value, child: Text(o.value)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      rol = value ?? '';
                    });
                  }),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  // autofocus: true,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Ingrese un correo valido",
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    hintText: 'Ingrese su correo',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                )),
            Padding(
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
                    } else if (passController.value != passController2.value) {
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
            ),
            Padding(
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
                    } else if (passController.value != passController2.value) {
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
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Usuario usuario = Usuario(
                        id: 0,
                        nombre: nombreController.text,
                        apellido: apellidoController.text,
                        telefono: telefonoController.text,
                        email: emailController.text,
                        password: encript.encript(passController.text),
                        rol: Rol(0, rol));

                    BlocProvider.of<NuevoUsuarioBloc>(context)
                        .add(NuevoUsuarioEventSave(usuario: usuario));
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  minimumSize: const Size(300, 50),
                ),
                child: const Text('Guardar'),
              ),
            ),
          ]),
        ));
  }
}
