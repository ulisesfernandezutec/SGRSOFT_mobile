import 'package:flutter/material.dart';

// function con context como parametro
AppBar appBar(BuildContext context) {
  return AppBar(
    title: const Image(image: AssetImage('assets/images/logo.png'), height: 50),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.add_alert),
        tooltip: 'Show Snackbar',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This is a snackbar')),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.navigate_next),
        tooltip: 'Next page',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => Scaffold(
                appBar: AppBar(title: const Text('Next page')),
                body: const Center(
                  child: Text(
                    'This is the next page',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.map_outlined),
        tooltip: 'Mapa',
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/mapa',
          );
        },
      ),
    ],
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
