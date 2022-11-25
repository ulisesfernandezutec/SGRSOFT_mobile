import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: double.infinity,
                    height: double.infinity,
                    margin: const EdgeInsets.all(10),
                    constraints: const BoxConstraints(
                        maxWidth: 500,
                        maxHeight: 500,
                        minWidth: 300,
                        minHeight: 300),
                    child: Card(
                        elevation: 3,
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5))),
                                child: Title(
                                    color: Theme.of(context).primaryColor,
                                    child: const Image(
                                      image:
                                          AssetImage('assets/images/logo.png'),
                                      width: 167,
                                      height: 58,
                                    ))),
                            // const Spacer(),
                            Container(
                                padding: const EdgeInsets.all(5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5))),
                                child: SignInButton(Buttons.Google,
                                    text: "Login con Google", onPressed: () {
                                  _handleSignIn(context);
                                })),

                            // SignInButton(Buttons.Facebook,
                            //     text: "Login con Facebook", onPressed: () {
                            //   Navigator.pushNamed(context,
                            //       ListadoPuntosRecoleccionScreens.routeName);
                            // })
                          ],
                        ))))));
  }
}
