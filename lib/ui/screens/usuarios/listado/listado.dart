// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:sgrsoft/domain/models/usuario.dart';
// // import 'package:sgrsoft/ui/pages/usuarios/detalle/detalle.dart';

// import 'package:http/http.dart' as http;

// // import '../detalle/detalle.dart';
// import '../nuevo/nuevo.dart';

// class ListadoUsuarios extends StatefulWidget {
//   const ListadoUsuarios({Key? key}) : super(key: key);

//   @override
//   _ListadoUsuariosState createState() => _ListadoUsuariosState();
// }

// // crear listado usuario
// class _ListadoUsuariosState extends State<ListadoUsuarios> {
//   List<Widget> listData = [const Text('Sin datos.')];
//   // Initial state
//   // Con un get usuario fech de la api
//   // url http://192.168.2.22:8080/usuario/
//   // basic auth usuario:demo pass:demo

//   @override
//   void initState() {
//     super.initState();
//     getDataList();
//     // setState(() {
//     //   isLoad = true;
//     // });
//     // Timer.periodic(const Duration(minutes: 1), (Timer timer) {
//     //   getDataList();
//     // });
//   }

//   Future<void> getDataList() async {
//     var username = 'demo';
//     var password = 'demo';
//     String basicAuth =
//         'Basic ${base64Encode(utf8.encode('$username:$password'))}';
//     var headers = {'Authorization': basicAuth};
//     var url = "http://192.168.2.22:8080/usuario/";
//     var response = await http.get(Uri.parse(url), headers: headers);
//     if (response.statusCode == 200) {
//       List<Usuario> usuarios = [];
//       (jsonDecode(utf8.decode(response.bodyBytes))).forEach((element) {
//         usuarios.add(Usuario.fromJson(element));
//       });

//       listData = usuarios.map<Widget>((Usuario u) {
//         return CardUser(usuario: u);
//       }).toList();

//       setState(() {
//         listData = listData;
//       });
//     } else {
//       throw Exception('Failed to load Data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Listado de usuarios'),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const AgregarUsuario(),
//               ),
//             );
//           },
//           child: const Icon(Icons.add),
//         ),
//         body: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Center(
//               child: Wrap(spacing: 10.0, runSpacing: 10.0, children: listData),
//             )));
//   }
// }

// class CardUser extends StatelessWidget {
//   const CardUser({Key? key, required this.usuario}) : super(key: key);
//   final Usuario usuario;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: 400.0,
//         // height: 300.0,
//         child: Card(
//           elevation: 8,
//           shadowColor: const Color.fromARGB(255, 117, 123, 128),
//           child: Column(
//             // mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 // leading: Icon(Icons.album),
//                 title: Text(usuario.username,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 17)),
//                 subtitle: Row(children: [Text(usuario.id.toString())]),
//                 tileColor: const Color.fromARGB(255, 219, 217, 217),
//               )
//             ],
//           ),
//         ));
//   }
// }
