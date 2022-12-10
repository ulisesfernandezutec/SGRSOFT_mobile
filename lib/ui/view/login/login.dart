import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgrsoft/data/services/social_auth.dart';
import 'package:sgrsoft/domain/services/social_auth_provider.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool isLogin = false;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

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

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

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
                                maxWidth: 450, maxHeight: 400),
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: Colors.white30, width: 2)),
                            child: Form(
                              key: _formKey,
                              child: Column(children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    width: double.infinity,
                                    child: const Image(
                                      image:
                                          AssetImage('assets/images/logo.png'),
                                      width: 167,
                                      height: 58,
                                    )),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: TextFormField(
                                      autofocus: true,
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
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: isLogin
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : ElevatedButton(
                                          onPressed: () async {
                                            // login(emailController.text, passController.text
                                            _formKey.currentState!.validate();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 3,
                                            minimumSize: const Size(300, 50),
                                          ),
                                          child: const Text('Entrar'),
                                        ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: Row(children: [
                                    const Text(
                                      "¿No tienes usuario? ",
                                      // style: const TextStyle(color: Colors.red),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/register',
                                          );
                                        },
                                        child: Text('Crear nuevo usuario.',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor)))
                                  ]),
                                ),
                                const Flexible(
                                    flex: 1,
                                    fit: FlexFit.loose,
                                    child: Spacer()),
                                const Flexible(
                                    fit: FlexFit.loose, child: Divider()),
                                Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 0, 10),
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SignInButton(Buttons.Google,
                                            text: "Entrar con Google",
                                            onPressed: () {
                                          _handleGoogleSignIn(context);
                                        })
                                      ],
                                    ))
                              ]),
                            )))))));
  }
}
