part of 'listado_bloc.dart';

abstract class ListadoPuntoSalidaEvent extends Equatable {
  const ListadoPuntoSalidaEvent();

  @override
  List<Object> get props => [];
}

class ListadoPuntoSalidaEventCargar extends ListadoPuntoSalidaEvent {}
