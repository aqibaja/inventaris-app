part of 'lokasi_bloc.dart';

abstract class LokasiState extends Equatable {
  const LokasiState();

  @override
  List<Object> get props => [];
}

class LokasiInitial extends LokasiState {}

//data api register / sigup selesai di get
class LokasiSukses extends LokasiState {
  final Position lokasi;
  LokasiSukses({this.lokasi});
}

class CheckGps extends LokasiState {
  final bool gps;
  CheckGps({this.gps});
}

class CheckPermission extends LokasiState {
  final LocationPermission permission;
  CheckPermission({this.permission});
}

class LokasiLoading extends LokasiState {}

class LokasiError extends LokasiState {
  final String error;
  LokasiError({this.error});
}
