import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'inventaris_event.dart';
part 'inventaris_state.dart';

class InventarisBloc extends Bloc<InventarisEvent, InventarisState> {
  InventarisBloc() : super(InventarisInitial());

  @override
  Stream<InventarisState> mapEventToState(
    InventarisEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
