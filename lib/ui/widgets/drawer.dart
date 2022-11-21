import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';
import 'package:sgrsoft/ui/settings/settings_view.dart';
import 'package:sgrsoft/ui/view/punto_salida/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:sgrsoft/ui/view/rol/listado/listado.dart';
import 'package:sgrsoft/ui/view/tipo_de_residuo/listado/listado.dart';
import 'package:sgrsoft/ui/view/vehiculo/listado/listado.dart';

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
          child: ImageStore().logo,
        ),
        ListTile(
            leading: const Icon(Icons.class_outlined),
            title: const Text('Rol de Usuario'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, ListadoRolScreen.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Servicios'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, ListadoPuntosRecoleccionScreens.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Puntos de Salida'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, ListadoPuntoSalidaScreen.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.class_outlined),
            title: const Text('Tipo de Residuos'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, ListadoTipoResiduos.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.car_crash_outlined),
            title: const Text('Vehiculos'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, ListadoVehiculoScreen.routeName);
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
