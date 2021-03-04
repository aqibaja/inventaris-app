// To parse this JSON data, do
//
//     final getInventarisModel = getInventarisModelFromJson(jsonString);

import 'dart:convert';

List<GetInventarisModel> getInventarisModelFromJson(String str) =>
    List<GetInventarisModel>.from(
        json.decode(str).map((x) => GetInventarisModel.fromJson(x)));

String getInventarisModelToJson(List<GetInventarisModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetInventarisModel {
  GetInventarisModel({
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
    this.imageQrcode,
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
  String imageQrcode;

  factory GetInventarisModel.fromJson(Map<String, dynamic> json) =>
      GetInventarisModel(
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
        imageQrcode: json["image_qrcode"],
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
        "image_qrcode": imageQrcode,
      };
}
