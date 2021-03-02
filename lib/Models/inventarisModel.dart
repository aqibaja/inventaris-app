// To parse this JSON data, do
//
//     final inventarisModel = inventarisModelFromJson(jsonString);

import 'dart:convert';

List<InventarisModel> inventarisModelFromJson(String str) =>
    List<InventarisModel>.from(
        json.decode(str).map((x) => InventarisModel.fromJson(x)));

String inventarisModelToJson(List<InventarisModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InventarisModel {
  InventarisModel({
    this.id,
    this.namaBarang,
    this.nomorBarang,
    this.tanggalPembukuan,
    this.tanggalService,
    this.tanggalMutasi,
    this.status,
    this.lokasi,
    this.longitude,
    this.latitude,
    this.image,
  });

  int id;
  String namaBarang;
  String nomorBarang;
  DateTime tanggalPembukuan;
  String tanggalService;
  String tanggalMutasi;
  String status;
  String lokasi;
  String longitude;
  String latitude;
  String image;

  factory InventarisModel.fromJson(Map<String, dynamic> json) =>
      InventarisModel(
        id: json["id"],
        namaBarang: json["nama_barang"],
        nomorBarang: json["nomor_barang"],
        tanggalPembukuan: DateTime.parse(json["tanggal_pembukuan"]),
        tanggalService: json["tanggal_service"],
        tanggalMutasi: json["tanggal_mutasi"],
        status: json["status"],
        lokasi: json["lokasi"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_barang": namaBarang,
        "nomor_barang": nomorBarang,
        "tanggal_pembukuan":
            "${tanggalPembukuan.year.toString().padLeft(4, '0')}-${tanggalPembukuan.month.toString().padLeft(2, '0')}-${tanggalPembukuan.day.toString().padLeft(2, '0')}",
        "tanggal_service": tanggalService,
        "tanggal_mutasi": tanggalMutasi,
        "status": status,
        "lokasi": lokasi,
        "longitude": longitude,
        "latitude": latitude,
        "image": image,
      };
}
