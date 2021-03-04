import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'service_dart_event.dart';
part 'service_dart_state.dart';

class ServiceDartBloc extends Bloc<ServiceDartEvent, ServiceDartState> {
  ServiceDartBloc() : super(ServiceDartInitial());

  @override
  Stream<ServiceDartState> mapEventToState(ServiceDartEvent event) async* {
    if (event is SelectEventService) {
      if (event.select == 1) {
        yield ServiceState();
      } else {
        yield MutasiState();
      }
    }
  }
}
