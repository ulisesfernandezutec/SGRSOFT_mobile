import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/domain/services/auth_provider.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';

GetIt getIt = GetIt.instance;
// function con context como parametro
AppBar appBar(BuildContext context) {
  return AppBar(
    title: ImageStore().logo,
    actions: [
      IconButton(
          onPressed: () {
            AuthenticationProvider auth = getIt<AuthenticationProvider>();
            auth.logout();
            Navigator.pushNamed(context, '/login');
          },
          tooltip: 'Cerrar sesión',
          icon: const Icon(Icons.logout_outlined)),
    ],
    // actions: <Widget>[
    //   IconButton(
    //     icon: const Icon(Icons.add_alert),
    //     tooltip: 'Show Snackbar',
    //     onPressed: () {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('This is a snackbar')),
    //       );
    //     },
    //   ),
    //   IconButton(
    //     icon: const Icon(Icons.navigate_next),
    //     tooltip: 'Next page',
    //     onPressed: () {
    //       Navigator.pushNamed(
    //         context,
    //         DemoParams.routeName,
    //         arguments: DemoParamsArguments(
    //             titulo: 'Demo de parametros', subtitulo: 'subtitulo', id: 1),
    //       );
    //     },
    //   ),
    //   IconButton(
    //     icon: const Icon(Icons.map_outlined),
    //     tooltip: 'Mapa',
    //     onPressed: () {
    //       Navigator.pushNamed(
    //         context,
    //         GoogleMapsSetPosition2.routeName,
    //       );
    //     },
    //   ),
    // ],
  );
}


// AppBar appBar(context conte)

// class AppBarMain extends StatelessWidget {
//   const AppBarMain({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title:
//           const Image(image: AssetImage('assets/images/logo.png'), height: 50),
//       actions: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.search),
//           tooltip: 'Search',
//           onPressed: () {
//             // do something
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.person),
//           tooltip: 'Search',
//           onPressed: () {
//             // do something
//           },
//         ),
//       ],
//     );
//   }
// }
