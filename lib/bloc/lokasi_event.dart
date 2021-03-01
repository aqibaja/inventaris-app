part of 'lokasi_bloc.dart';

abstract class LokasiEvent extends Equatable {
  const LokasiEvent();

  @override
  List<Object> get props => [];
}

class CheckLokasiEvent extends LokasiEvent {}

class ClearLokasiEvent extends LokasiEvent {}
