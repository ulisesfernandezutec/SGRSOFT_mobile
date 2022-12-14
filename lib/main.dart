import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/detalle/detalle_bloc.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/blocs/rol/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/blocs/rol/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/blocs/tipos_residuos/editar/editar_bloc.dart';
import 'package:sgrsoft/domain/blocs/tipos_residuos/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/blocs/tipos_residuos/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/blocs/usuario/detalle/detalle_bloc.dart';
import 'package:sgrsoft/domain/blocs/usuario/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/blocs/usuario/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/domain/blocs/vehiculo/editar/editar_bloc.dart';
import 'package:sgrsoft/domain/blocs/vehiculo/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/blocs/vehiculo/nuevo/nuevo_bloc.dart';
import 'package:sgrsoft/ui/app.dart';
import 'package:sgrsoft/ui/settings/settings_controller.dart';
import 'package:sgrsoft/ui/settings/settings_service.dart';
import 'package:sgrsoft/di/di.dart' as di;

import 'data/streams/streams.dart';

import 'domain/blocs/punto_disposicion_final/add/nuevo_bloc.dart';
import 'domain/blocs/punto_salida/add/nuevo_bloc.dart';
import 'domain/blocs/usuario/editar/editar_bloc.dart';

void main() async {
  // Cargamos get_it
  // getit nos permite cargar de forma automatica las dependencias.
  await di.initializeDI();
  StartStreams();

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => ListadoPuntosRecoleccionBloc()
              ..add(LoadListadoPuntosRecoleccionEvent())),
        BlocProvider(
            create: (BuildContext context) => DetallePuntosRecoleccionBloc()),
        BlocProvider(
            create: (BuildContext context) => EditarTipoDeResiduoBloc()),
        BlocProvider(
            create: (BuildContext context) => ListadoTipoDeResiduosBloc()
              ..add(LoadListadoTiposDeResiduosEvent())),
        BlocProvider(
            create: (BuildContext context) =>
                ListadoRolBloc()..add(LoadListadoRolEvent())),
        BlocProvider(create: (BuildContext context) => NuevoRolBloc()),
        BlocProvider(
            create: (BuildContext context) => NuevoTipoDeResiduoBloc()),
        BlocProvider(
            create: (BuildContext context) =>
                ListadoVehiculoBloc()..add(LoadListadoVehiculoEvent())),
        BlocProvider(create: (BuildContext context) => NuevoVehiculoBloc()),
        BlocProvider(create: (BuildContext context) => EditarVehiculoBloc()),
        BlocProvider(create: (BuildContext context) => NuevoPuntoSalidaBloc()),
        BlocProvider(
            create: (BuildContext context) => NuevoPuntoDisposicionFinalBloc()),
        BlocProvider(create: (BuildContext context) => ListadoUsuarioBloc()),
        BlocProvider(create: (BuildContext context) => NuevoUsuarioBloc()),
        BlocProvider(create: (BuildContext context) => DetalleUsuarioBloc()),
        BlocProvider(create: (BuildContext context) => EditarUsuarioBloc())
        // BlocProvider(create: (BuildContext context) => DetalleVehiculoBloc()),
      ],
      child: MainApp(
        settingsController: settingsController,
      )));
}
