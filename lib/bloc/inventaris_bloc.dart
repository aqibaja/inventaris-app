import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventaris_app_ptpn1/Api_Services/add_inventaris_service.dart';
import 'package:inventaris_app_ptpn1/Models/AddInventarisModel.dart';

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
        var data = await InventarisService().RegisterInventarisData(
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
    if (event is ClearEventInventaris) {
      yield InventarisInitial();
    }
  }
}
