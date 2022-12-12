import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgrsoft/data/services/social_auth.dart';
import 'package:sgrsoft/domain/services/social_auth_provider.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:email_validator/email_validator.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});
  static const routeName = '/registro';
  @override
  State<StatefulWidget> createState() {
    return RegistroScreenState();
  }
}

class RegistroScreenState extends State<RegistroScreen> {
  bool isLogin = false;

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

  Future<void> _handleGoogleSignIn(context) async {
    try {
      bool login =
          await SocialAuth(tipo: SocialAuthenticationProviderOption.google)
              .login();

      if (login) {
        Navigator.pushReplacementNamed(
            context, ListadoPuntosRecoleccionScreens.routeName);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void dispose() {
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
                                          validator: ((value) => value!.isEmpty
                                              ? "Repita su contraseña"
                                              : null),
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: isLogin
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : ElevatedButton(
                                              onPressed: () async {
                                                // login(emailController.text, passController.text
                                                _formKey.currentState!
                                                    .validate();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 3,
                                                minimumSize:
                                                    const Size(300, 50),
                                              ),
                                              child: const Text('Registrar'),
                                            ),
                                    ),
                                  ]),
                                ))))))));
  }
}
