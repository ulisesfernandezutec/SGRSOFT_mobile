import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sgrsoft/ui/view/demogooglemaps/maps.dart';
import 'package:sgrsoft/ui/view/demomodal/demomodal.dart';
import 'package:sgrsoft/ui/view/demoparams/demoparams.dart';
import 'package:sgrsoft/ui/view/login/google.dart';
import 'package:sgrsoft/ui/view/login/login.dart';
import 'package:sgrsoft/ui/view/punto_disposicion_final/listado/listado.dart';
import 'package:sgrsoft/ui/view/punto_salida/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/detalle/detalle.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/editar/_editar.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/listado/listado.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/mapa/mapa.dart';
import 'package:sgrsoft/ui/settings/settings_controller.dart';
import 'package:sgrsoft/ui/settings/settings_view.dart';
import 'package:sgrsoft/ui/view/rol/listado/listado.dart';
import 'package:sgrsoft/ui/view/ruta/add/add.dart';
import 'package:sgrsoft/ui/view/tipo_de_residuo/listado/listado.dart';
import 'package:sgrsoft/ui/view/vehiculo/listado/listado.dart';
import 'package:sgrsoft/ui/widgets/custom_error.dart';
import 'package:sgrsoft/ui/widgets/google_maps/test.dart';

import 'view/punto_salida/nuevo/nuevo.dart';
import 'view/puntos_recoleccion/nuevo/nuevo.dart';
import 'widgets/google_maps/select_position2.dart';

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          builder: (BuildContext context, Widget? widget) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return CustomError(errorDetails: errorDetails);
            };
            return widget!;
          },
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('es', ''), // Español, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.lightGreen,
            useMaterial3: settingsController.isMaterial3,
            fontFamily: 'Ubuntu',
          ),
          // theme: ThemeData(
          //     // primarySwatch: const Color(0xff8ac53f), //Colors.green
          //     brightness: Brightness.light,
          //     colorScheme: ColorScheme.fromSwatch().copyWith(
          //       primary: const Color(0xff8ac53f),
          //       secondary: const Color.fromARGB(255, 96, 133, 48),
          //       primaryContainer: const Color.fromARGB(255, 216, 245, 179),
          //       shadow: const Color.fromARGB(255, 19, 32, 3),
          //       error: const Color.fromARGB(255, 255, 84, 84),
          //       onSurface: const Color.fromARGB(255, 122, 206, 122),
          //       // outline: const Color.fromARGB(255, 81, 218, 46),
          //       outline: const Color.fromARGB(255, 119, 145, 119),
          //     ),
          //     useMaterial3: true,
          //     fontFamily: 'Ubuntu'),
          darkTheme: ThemeData.dark(
            useMaterial3: settingsController.isMaterial3,
          ),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.

          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case ListadoPuntosRecoleccionScreens.routeName:
                    return const ListadoPuntosRecoleccionScreens();
                  case MapaPuntosRecoleccion.routeName:
                    return const MapaPuntosRecoleccion();
                  case DetallePuntosRecoleccionScreens.routeName:
                    return const DetallePuntosRecoleccionScreens();
                  case EditarPuntosRecoleccionScreens.routeName:
                    return const EditarPuntosRecoleccionScreens();
                  case NuevoPuntosRecoleccionScreens.routeName:
                    return const NuevoPuntosRecoleccionScreens();
                  case DemoParams.routeName:
                    return const DemoParams();
                  case DemoModal.routeName:
                    return const DemoModal();
                  case MyGoogleMaps.routeName:
                    return const MyGoogleMaps();
                  // Tipo de Residuos
                  case ListadoTipoResiduos.routeName:
                    return const ListadoTipoResiduos();
                  case ListadoRolScreen.routeName:
                    return const ListadoRolScreen();
                  case ListadoVehiculoScreen.routeName:
                    return const ListadoVehiculoScreen();
                  case GoogleMapsSetPosition2.routeName:
                    return const GoogleMapsSetPosition2();
                  case AddRutaScreen.routeName:
                    return const AddRutaScreen();
                  case SignInGoogle.routeName:
                    return const SignInGoogle();
                  case PolylineMap.routeName:
                    return const PolylineMap();
                  case ListadoPuntoSalidaScreen.routeName:
                    return const ListadoPuntoSalidaScreen();
                  case NuevoPuntoSalidaScreen.routeName:
                    return const NuevoPuntoSalidaScreen();
                  case ListadoPuntoDisposicionFinalScreen.routeName:
                    return const ListadoPuntoDisposicionFinalScreen();
                  default:
                    return const LoginScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
