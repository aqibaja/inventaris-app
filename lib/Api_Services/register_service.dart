import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:inventaris_app_ptpn1/Models/register_models.dart';
import 'package:inventaris_app_ptpn1/Ulrs/Urls.dart';

abstract class RegisterRepo {
  Future<RegisterModel> getRegisterData(String username, String email,
      String jenisKelamin, String password, String noHp);
}

//ini class untuk get data dari json
class RegisterServices implements RegisterRepo {
  RegisterModel registerData;
  @override
  Future<RegisterModel> getRegisterData(String username, String email,
      String jenisKelamin, String password, String noHp) async {
    Map data = {
      'name': username,
      'email': email,
      'gender': jenisKelamin,
      'password': password,
      'no_hp': noHp
    };
    String bodyPost = json.encode(data);
    String url =
        Urls.ALL_INVENTARIS_URL + "flutter-udacoding1/public/user/register";

    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 201 || statusCode == 400) {
      registerData = RegisterModel.fromJson(body);
      return registerData;
    } else {
      return registerData;
    }
  }
}
