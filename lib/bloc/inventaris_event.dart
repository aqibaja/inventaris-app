part of 'inventaris_bloc.dart';

abstract class InventarisEvent extends Equatable {
  const InventarisEvent();

  @override
  List<Object> get props => [];
}

class DetailInventarisEvent extends InventarisEvent {
  final String idInventaris;

  DetailInventarisEvent({this.idInventaris});
}

class AddInventarisEvent extends InventarisEvent {
  final String nomorBarang;
  final String namaBarang;
  final String tanggalPembukuan;
  final String lokasi;
  final String longitude;
  final String latitude;
  final File image;

  AddInventarisEvent(
      {this.nomorBarang,
      this.namaBarang,
      this.tanggalPembukuan,
      this.lokasi,
      this.image,
      this.latitude,
      this.longitude});
}

class ClearEventInventaris extends InventarisEvent {}
