import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/usuario.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sgrsoft/domain/services/encriptar.dart';

GetIt getIt = GetIt.instance;
final encript = Encriptrar();

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});
  static const routeName = '/registro';
  @override
  State<StatefulWidget> createState() {
    return RegistroScreenState();
  }
}

class RegistroScreenState extends State<RegistroScreen> {
  UsuarioRepository usuarioRepository = getIt.get();

  bool isLogin = false;
  bool registro = false;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passController2 = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final telefonoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordFocusNode2 = FocusNode();
  final FocusNode _nombreFocusNode = FocusNode();
  final FocusNode _apellidoFocusNode = FocusNode();
  final FocusNode _telefonoFocusNode = FocusNode();

  Future<void> _handleRegistro() async {
    try {
      Usuario usuario = Usuario(
          email: emailController.text,
          password: encript.encript(passController.text),
          nombre: nombreController.text,
          apellido: apellidoController.text,
          telefono: telefonoController.text,
          rol: Rol(0, 'Usuario'),
          estado: 'Inactivo');

      bool result = await usuarioRepository.registrar(usuario);

      setState(() {
        registro = result;
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void dispose() {
    bool registrado = false;
    // Clean up the controller when the widget is disposed.
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
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.jpg'),
                        fit: BoxFit.cover)),
                child: Center(
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            constraints: const BoxConstraints(
                                maxWidth: 450, maxHeight: 650),
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.90),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: Colors.white30, width: 2)),
                            child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                        width: double.infinity,
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/images/logo.png'),
                                          width: 167,
                                          height: 58,
                                        )),
                                    Text("Registro de usuario",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold)),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        child: TextFormField(
                                          autofocus: true,
                                          focusNode: _nombreFocusNode,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: ((value) => value!.isEmpty
                                              ? "Ingrese su nombre"
                                              : null),
                                          controller: nombreController,
                                          decoration: const InputDecoration(
                                            labelText: 'Nombre',
                                            hintText: 'Ingrese su nombre',
                                            prefixIcon: Icon(
                                                Icons.person_outline_outlined),
                                            border: OutlineInputBorder(),
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: TextFormField(
                                          autofocus: true,
                                          focusNode: _apellidoFocusNode,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: ((value) => value!.isEmpty
                                              ? "Ingrese su apellido"
                                              : null),
                                          controller: apellidoController,
                                          decoration: const InputDecoration(
                                            labelText: 'Apellido',
                                            hintText: 'Ingrese su apellido',
                                            prefixIcon: Icon(Icons
                                                .person_add_alt_1_outlined),
                                            border: OutlineInputBorder(),
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: TextFormField(
                                          autofocus: true,
                                          focusNode: _telefonoFocusNode,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: ((value) => value!.isEmpty
                                              ? "Ingrese su teléfono"
                                              : null),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: TextFormField(
                                          // autofocus: true,
                                          focusNode: _emailFocusNode,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) =>
                                              EmailValidator.validate(value!)
                                                  ? null
                                                  : "Ingrese un correo valido",
                                          controller: emailController,
                                          decoration: const InputDecoration(
                                            labelText: 'Correo',
                                            hintText: 'Ingrese su correo',
                                            prefixIcon:
                                                Icon(Icons.email_outlined),
                                            border: OutlineInputBorder(),
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: TextFormField(
                                          focusNode: _passwordFocusNode,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textInputAction: TextInputAction.done,
                                          controller: passController,
                                          obscureText: true,
                                          validator: ((value) => value!.isEmpty
                                              ? "Ingrese su contraseña"
                                              : null),
                                          decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.key_outlined),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: TextFormField(
                                          focusNode: _passwordFocusNode2,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textInputAction: TextInputAction.done,
                                          controller: passController2,
                                          obscureText: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Repita la contraseña";
                                            } else if (passController.value !=
                                                passController2.value) {
                                              return "Las contraseñas no coinciden";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.key_outlined),
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
                                    registro
                                        ? Container(
                                            padding: EdgeInsets.all(10),
                                            child: const Text(
                                              "Registro exitoso, confime su mail y por favor inicie sesión",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ))
                                        : Container(),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 10),
                                        child: isLogin
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : ButtonBar(
                                                alignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        elevation: 3,
                                                        minimumSize:
                                                            const Size(150, 50),
                                                      ),
                                                      child: const Text(
                                                          'Cancelar'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        // login(emailController.text, passController.text
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          await _handleRegistro();
                                                        }
                                                        ;
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 3,
                                                        minimumSize:
                                                            const Size(150, 50),
                                                      ),
                                                      child: const Text(
                                                          'Registrar'),
                                                    ),
                                                  ])),
                                  ]),
                                ))))))));
  }
}
