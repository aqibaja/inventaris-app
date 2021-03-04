part of 'service_dart_bloc.dart';

abstract class ServiceDartState extends Equatable {
  const ServiceDartState();

  @override
  List<Object> get props => [];
}

class ServiceDartInitial extends ServiceDartState {}

class ServiceState extends ServiceDartState {}

class MutasiState extends ServiceDartState {}
