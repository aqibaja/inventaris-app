part of 'service_dart_bloc.dart';

abstract class ServiceDartEvent extends Equatable {
  const ServiceDartEvent();

  @override
  List<Object> get props => [];
}

class SelectEventService extends ServiceDartEvent {
  final int select;
  SelectEventService({this.select});
}
