part of 'bloc.dart';

abstract class AddRutaEvent extends Equatable {
  const AddRutaEvent();

  @override
  List<Object> get props => [];
}

class LoadAddRutaEvent extends AddRutaEvent {
  const LoadAddRutaEvent();
}
