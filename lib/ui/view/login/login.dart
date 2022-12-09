import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:email_validator/email_validator.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

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

  Future<void> _handleSignIn(context) async {
    try {
      final result = await _googleSignIn.signIn();
      final GoogleSignInAuthentication ggAuth = await result!.authentication;
      if (kDebugMode) {
        print(ggAuth.idToken);
        print(ggAuth.accessToken);
        print(_googleSignIn.currentUser);
      }

      Navigator.pushReplacementNamed(
          context, ListadoPuntosRecoleccionScreens.routeName);
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
                                          _handleSignIn(context);
                                        })
                                      ],
                                    ))
                                // ),
                              ]),
                            )))))));
  }
}
// class LoginScreenState extends State<LoginScreen> {
//   Future<void> _handleSignIn(context) async {
//     try {
//       final result = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication ggAuth = await result!.authentication;
//       if (kDebugMode) {
//         print(ggAuth.idToken);
//         print(ggAuth.accessToken);
//         print(_googleSignIn.currentUser);
//       }

//       Navigator.pushReplacementNamed(
//           context, ListadoPuntosRecoleccionScreens.routeName);
//     } catch (error) {
//       if (kDebugMode) {
//         print(error);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             body: Center(
//                 child: Container(
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                     width: double.infinity,
//                     height: double.infinity,
//                     margin: const EdgeInsets.all(10),
//                     constraints: const BoxConstraints(
//                       maxWidth: 450,
//                       maxHeight: 500,
//                       // minWidth: 300,
//                       // minHeight: 300
//                     ),
//                     child: ClipRRect(
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10)),
//                         child: Card(
//                             elevation: 3,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                     width: double.infinity,
//                                     padding: const EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor,
//                                         borderRadius: const BorderRadius.only(
//                                             topLeft: Radius.circular(5),
//                                             topRight: Radius.circular(5))),
//                                     child: Title(
//                                         color: Theme.of(context).primaryColor,
//                                         child: const Image(
//                                           image: AssetImage(
//                                               'assets/images/logo.png'),
//                                           width: 167,
//                                           height: 58,
//                                         ))),
//                                 // const Spacer(),
//                                 Container(
//                                     padding: const EdgeInsets.all(5),
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor,
//                                         borderRadius: const BorderRadius.only(
//                                             bottomLeft: Radius.circular(5),
//                                             bottomRight: Radius.circular(5))),
//                                     child: SignInButton(Buttons.Google,
//                                         text: "Login con Google",
//                                         onPressed: () {
//                                       _handleSignIn(context);
//                                     })),

//                                 // SignInButton(Buttons.Facebook,
//                                 //     text: "Login con Facebook", onPressed: () {
//                                 //   Navigator.pushNamed(context,
//                                 //       ListadoPuntosRecoleccionScreens.routeName);
//                                 // })
//                               ],
//                             )))))));
//   }
// }
