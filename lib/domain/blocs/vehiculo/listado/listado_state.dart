part of 'listado_bloc.dart';

abstract class ListadoVehiculoState {
  List<Vehiculo> vehiculo;

  ListadoVehiculoState({required this.vehiculo});
}

class ListadoInitialVehiculoState extends ListadoVehiculoState {
  ListadoInitialVehiculoState() : super(vehiculo: []);
}

class ListadoSuccessVehiculoState extends ListadoVehiculoState {
  ListadoSuccessVehiculoState({required List<Vehiculo> vehiculo})
      : super(vehiculo: vehiculo);
}

// ListadoErrorVehiculoState
class ListadoErrorVehiculoState extends ListadoVehiculoState {
  ListadoErrorVehiculoState() : super(vehiculo: []);
}
