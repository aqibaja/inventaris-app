import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:inventaris_app_ptpn1/Models/AddInventarisModel.dart';
import 'package:inventaris_app_ptpn1/Models/FailInventarisModel.dart';
import 'package:inventaris_app_ptpn1/Models/GetInventarisModel.dart';
import 'package:inventaris_app_ptpn1/Ulrs/Urls.dart';

abstract class InventarisRepo {
  Future<AddInventarisModel> registerInventarisData(
    String namaBarang,
    String nomorBarang,
    String tanggalPembukuan,
    String lokasi,
    String longitude,
    String latitude,
    File image,
  );
  Future<dynamic> getInventarisData(
    String nomorBarang,
  );
}

class InventarisService implements InventarisRepo {
  AddInventarisModel addInventarisStatus;
  GetInventarisModel getInventarisModel;
  @override
  Future<AddInventarisModel> registerInventarisData(
    String namaBarang,
    String nomorBarang,
    String tanggalPembukuan,
    String lokasi,
    String longitude,
    String latitude,
    File image,
  ) async {
    Map data = {
      'nama_barang': namaBarang,
      'nomor_barang': nomorBarang,
      'tanggal_pembukuan': tanggalPembukuan,
      'lokasi': lokasi,
      'longitude': longitude,
      'latitude': latitude,
    };
    //String bodyPost = json.encode(data);
    String url = Urls.ALL_INVENTARIS_URL + "inventaris";
    final uri = Uri.parse(url);

    if (image != null) {
      var request = http.MultipartRequest('POST', uri);
      request.fields['nama_barang'] = namaBarang;
      request.fields['nomor_barang'] = nomorBarang;
      request.fields['tanggal_pembukuan'] = tanggalPembukuan;
      request.fields['lokasi'] = lokasi;
      request.fields['longitude'] = longitude;
      request.fields['latitude'] = latitude;
      var pic = await http.MultipartFile.fromPath('image', image.path);
      request.files.add(pic);
      var response = await request.send();
      int statusCode = response.statusCode;
      var responseBody = await http.Response.fromStream(response);
      final body = json.decode(responseBody.body);

      if (statusCode == 200) {
        print("berhasil upload!!!");
        print(body);
        addInventarisStatus = AddInventarisModel.fromJson(body);
        return addInventarisStatus;
      } else {
        print("gagal upload!!!");
        print(body);
        addInventarisStatus = AddInventarisModel.fromJson(body);
        return addInventarisStatus;
      }
    } else {
      String bodyPost = json.encode(data);
      Response response = await http.post(url,
          body: bodyPost, headers: {"Content-Type": "application/json"});
      int statusCode = response.statusCode;
      final body = json.decode(response.body);
      print(body);
      if (statusCode == 200) {
        addInventarisStatus = AddInventarisModel.fromJson(body);
        return addInventarisStatus;
      } else if (statusCode == 400) {
        addInventarisStatus = AddInventarisModel.fromJson(body);
        return addInventarisStatus;
      } else {
        return addInventarisStatus;
      }
    }
  }

  @override
  Future<dynamic> getInventarisData(String nomorBarang) async {
    FailInventarisModel failInventarisModel;
    Map data = {
      'nomor_barang': nomorBarang,
    };
    //String bodyPost = json.encode(data);
    String url = Urls.ALL_INVENTARIS_URL + "inventaris-detail";
    final uri = Uri.parse(url);

    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      getInventarisModel = GetInventarisModel.fromJson(body);
      return getInventarisModel;
    } else if (statusCode == 400) {
      failInventarisModel = null;
      return failInventarisModel;
    } else {
      return getInventarisModel;
    }
  }
}
