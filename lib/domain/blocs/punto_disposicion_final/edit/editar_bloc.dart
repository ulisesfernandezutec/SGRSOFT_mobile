// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'editar_event.dart';
part 'editar_state.dart';

class EditarBloc extends Bloc<EditarEvent, EditarPuntoDisposicionFinalState> {
  EditarBloc() : super(EditarPuntoDisposicionFinalInitial()) {
    on<EditarEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
