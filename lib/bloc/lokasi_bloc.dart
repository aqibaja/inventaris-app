import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventaris_app_ptpn1/function/get_location.dart';
import 'package:geolocator/geolocator.dart';

part 'lokasi_event.dart';
part 'lokasi_state.dart';

class LokasiBloc extends Bloc<LokasiEvent, LokasiState> {
  LokasiBloc() : super(LokasiInitial());
  LocationPermission permission;

  @override
  Stream<LokasiState> mapEventToState(LokasiEvent event) async* {
    if (event is CheckLokasiEvent) {
      try {
        yield LokasiLoading();
        //Future.delayed(Duration(seconds: 2));
        bool gps = await LokasiFunction().checkGps();
        yield CheckGps(gps: gps);
        if (gps == true) {
          permission = await LokasiFunction().checkPermission();
          yield CheckPermission(permission: permission);
        }
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          Position lokasi = await LokasiFunction().getLokasiData();
          yield LokasiSukses(lokasi: lokasi);
        }
      } catch (e) {
        LokasiError(error: e.toString());
      }
    }
    if (event is ClearLokasiEvent) {
      yield LokasiInitial();
    }
  }
}
