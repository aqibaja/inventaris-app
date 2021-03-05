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
    this.imageQrcode,
  });

  int id;
  String namaBarang;
  String nomorBarang;
  DateTime tanggalPembukuan;
  String tanggalService;
  String tanggalMutasi;
  Status status;
  String lokasi;
  String longitude;
  String latitude;
  String image;
  String imageQrcode;

  factory InventarisModel.fromJson(Map<String, dynamic> json) =>
      InventarisModel(
        id: json["id"],
        namaBarang: json["nama_barang"],
        nomorBarang: json["nomor_barang"],
        tanggalPembukuan: DateTime.parse(json["tanggal_pembukuan"]),
        tanggalService: json["tanggal_service"],
        tanggalMutasi: json["tanggal_mutasi"],
        status: statusValues.map[json["status"]],
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
        "status": statusValues.reverse[status],
        "lokasi": lokasi,
        "longitude": longitudeValues.reverse[longitude],
        "latitude": latitudeValues.reverse[latitude],
        "image": image,
        "image_qrcode": imageQrcodeValues.reverse[imageQrcode],
      };
}

enum ImageQrcode {
  EMPTY,
  STORAGE_APP_PUBLIC_IMG_121312312412112121211111121213131_PNG,
  STORAGE_APP_PUBLIC_IMG_1213123124121333_PNG
}

final imageQrcodeValues = EnumValues({
  "": ImageQrcode.EMPTY,
  "/storage/app/public/img-121312312412112121211111121213131.png":
      ImageQrcode.STORAGE_APP_PUBLIC_IMG_121312312412112121211111121213131_PNG,
  "/storage/app/public/img-1213123124121333.png":
      ImageQrcode.STORAGE_APP_PUBLIC_IMG_1213123124121333_PNG
});

enum Latitude { EMPTY, THE_554829 }

final latitudeValues =
    EnumValues({"": Latitude.EMPTY, "5.54829": Latitude.THE_554829});

enum Longitude { EMPTY, THE_95323755 }

final longitudeValues =
    EnumValues({"": Longitude.EMPTY, "95.323755": Longitude.THE_95323755});

enum Status { NEW }

final statusValues = EnumValues({"New": Status.NEW});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
