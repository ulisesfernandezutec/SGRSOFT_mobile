import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/settings/settings_view.dart';
import 'package:sgrsoft/ui/view/tipo_de_residuo/listado/listado.dart';

Drawer appDrawer(BuildContext context) {
  Drawer drawer = Drawer(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const Text(
            'Drawer Header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Servicios'),
            onTap: () {
              Navigator.restorablePushNamed(context, '/');
            }),
        ListTile(
            leading: const Icon(Icons.class_outlined),
            title: const Text('Tipo de Residuos'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, ListadoTipoResiduos.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Mapa'),
            onTap: () {
              Navigator.restorablePushNamed(context, '/mapa');
            }),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.restorablePushNamed(context, SettingsView.routeName);
          },
        ),
      ],
    ),
  );
  return drawer;
}
