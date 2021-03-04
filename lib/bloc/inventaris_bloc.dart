import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventaris_app_ptpn1/Api_Services/inventaris_service.dart';
import 'package:inventaris_app_ptpn1/Models/AddInventarisModel.dart';
import 'package:inventaris_app_ptpn1/Models/FailInventarisModel.dart';
import 'package:inventaris_app_ptpn1/Models/GetInventarisModel.dart';

part 'inventaris_event.dart';
part 'inventaris_state.dart';

class InventarisBloc extends Bloc<InventarisEvent, InventarisState> {
  InventarisBloc() : super(InventarisInitial());

  @override
  Stream<InventarisState> mapEventToState(InventarisEvent event) async* {
    if (event is AddInventarisEvent) {
      try {
        yield AddInventarisLoading();
        //Future.delayed(Duration(seconds: 2));
        var data = await InventarisService().registerInventarisData(
            event.namaBarang,
            event.nomorBarang,
            event.tanggalPembukuan,
            event.lokasi,
            event.longitude,
            event.latitude,
            event.image);
        yield AddInventarisSuccess(addInventarisModel: data);
      } catch (e) {
        AddInventarisError(error: e.toString());
      }
    }
    if (event is GetInventarisEvent) {
      try {
        yield GetInventarisLoading();
        //Future.delayed(Duration(seconds: 2));
        var data =
            await InventarisService().getInventarisData(event.nomorInventaris);
        if (data == null) {
          yield GetInventarisFail(failInventarisModel: data);
        } else
          yield GetInventarisSuccess(getInventarisModel: data);
      } catch (e) {
        GetInventarisError(error: e.toString());
      }
    }
    if (event is ClearEventInventaris) {
      yield InventarisInitial();
    }
  }
}
