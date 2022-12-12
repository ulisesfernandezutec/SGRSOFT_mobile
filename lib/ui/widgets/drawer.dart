import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';
import 'package:sgrsoft/ui/settings/settings_view.dart';
import 'package:sgrsoft/ui/view/punto_disposicion_final/listado/listado.dart';
import 'package:sgrsoft/ui/view/punto_salida/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/mapa/mapa.dart';
import 'package:sgrsoft/ui/view/rol/listado/listado.dart';
import 'package:sgrsoft/ui/view/ruta/listado/listado.dart';
import 'package:sgrsoft/ui/view/test/route_optimize.dart';
import 'package:sgrsoft/ui/view/tipo_de_residuo/listado/listado.dart';
import 'package:sgrsoft/ui/view/usuario/listado/listado.dart';
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
          leading: const Icon(Icons.map_outlined),
          title: const Text('Mapa de Puntos'),
          onTap: () {
            Navigator.pushNamed(context, MapaPuntosRecoleccion.routeName);
          },
        ),
        ListTile(
            leading: const Icon(Icons.auto_delete_outlined),
            title: const Text('Puntos de Recolección'),
            onTap: () {
              Navigator.pushNamed(
                  context, ListadoPuntosRecoleccionScreens.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text('Puntos de Salida'),
            onTap: () {
              Navigator.pushNamed(context, ListadoPuntoSalidaScreen.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Puntos de Disposición Final'),
            onTap: () {
              Navigator.pushNamed(
                  context, ListadoPuntoDisposicionFinalScreen.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.route_outlined),
            title: const Text('Rutas'),
            onTap: () {
              Navigator.pushNamed(context, ListadoRutaScreen.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.class_outlined),
            title: const Text('Tipos de Residuos'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, ListadoTipoResiduos.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.local_shipping_outlined),
            title: const Text('Camiones'),
            onTap: () {
              Navigator.restorablePushNamed(
                  context, ListadoVehiculoScreen.routeName);
            }),
        ListTile(
            leading: const Icon(Icons.query_stats_outlined),
            title: const Text('Datos'),
            onTap: () {}),
        ListTile(
          leading: const Icon(Icons.people_alt_outlined),
          title: const Text('Usuarios'),
          onTap: () {
            Navigator.pushNamed(context, ListadoUsuarioScreen.routeName);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          onTap: () {
            Navigator.restorablePushNamed(context, SettingsView.routeName);
          },
        ),
        ListTile(
          leading: const Icon(Icons.route_outlined),
          title: const Text('Pueba de Rutas'),
          onTap: () {
            Navigator.pushNamed(context, RouteOptimize.routeName);
          },
        ),
      ],
    ),
  );
  return drawer;
}
