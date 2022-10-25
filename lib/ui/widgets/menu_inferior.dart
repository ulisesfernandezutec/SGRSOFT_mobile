import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/view/demomodal/demomodal.dart';
import 'package:sgrsoft/ui/view/demoparams/demoparams.dart';

List<Widget> menuInferior(BuildContext context) {
  List<Widget> menu = [
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
      icon: const Icon(Icons.numbers),
      tooltip: 'Next page',
      onPressed: () {
        Navigator.pushNamed(context, DemoParams.routeName,
            arguments: DemoParamsArguments(
                titulo: 'titulo1', subtitulo: 'subtitulo1', id: 1));
      },
    ),
    IconButton(
      icon: const Icon(Icons.navigate_next),
      tooltip: 'Next page',
      onPressed: () {
        Navigator.pushNamed(context, DemoParams.routeName,
            arguments: DemoParamsArguments(
                titulo: 'titulo2', subtitulo: 'subtitulo2', id: 2));
      },
    ),
    IconButton(
      icon: const Icon(Icons.screen_lock_landscape),
      tooltip: 'Modal',
      onPressed: () {
        Navigator.pushNamed(
          context,
          DemoModal.routeName,
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
    IconButton(
      icon: const Icon(Icons.map_outlined),
      tooltip: 'Google Maps',
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/google_maps',
        );
      },
    ),
  ];
  return menu;
}
