// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:sgrsoft/domain/models/usuario.dart';

// import 'package:http/http.dart' as http;

// // Agregar usuario widget
// class AgregarUsuario extends StatefulWidget {
//   const AgregarUsuario({Key? key}) : super(key: key);

//   @override
//   _AgregarUsuarioState createState() => _AgregarUsuarioState();
// }

// class _AgregarUsuarioState extends State<AgregarUsuario> {
//   final _formKey = GlobalKey<FormState>();
//   final _usuarioController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String result = "";

//   Future<void> saveUsuario() async {
//     var username = 'demo';
//     var password = 'demo';

//     String basicAuth =
//         'Basic ${base64Encode(utf8.encode('$username:$password'))}';
//     var headers = {'Authorization': basicAuth};
//     var url = "http://192.168.2.22:8080/usuario/";
//     var response = await http.post(Uri.parse(url),
//         headers: headers, body: Usuario(0, 'ulises', 'password','sd','as').toJson());
//     if (response.statusCode == 200) {
//       setState(() {
//         result = utf8.decode(response.bodyBytes);
//       });
//     } else {
//       throw Exception('Failed to load Data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Agregar usuario'),
//         ),
//         body: Form(
//             key: _formKey,
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: _usuarioController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Usuario',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Ingrese el usuario';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       controller: _passwordController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Password',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Ingrese el password';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // if (_formKey.currentState!.validate()) {
//                       saveUsuario();
//                       // }
//                     },
//                     child: const Text('Agregar'),
//                   ),
//                   Text(result)
//                 ])));
//   }
// }
