import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:inventaris_app_ptpn1/Models/login_models.dart';
import 'package:inventaris_app_ptpn1/Ulrs/Urls.dart';

abstract class LoginRepo {
  Future<dynamic> getLoginData(String email, String password);
}

//ini class untuk get data dari json
class LoginServices implements LoginRepo {
  var registerData;
  @override
  Future<dynamic> getLoginData(String email, String password) async {
    Map data = {
      'email': email,
      'password': password,
    };
    String bodyPost = json.encode(data);
    String url =
        Urls.ALL_INVENTARIS_URL + "flutter-udacoding1/public/user/login";

    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 201) {
      registerData = LoginModel.fromJson(body);
      return registerData;
    } else if (statusCode == 400) {
      registerData = LoginModel.fromJson(body);
      return registerData;
    } else {
      return registerData;
    }
  }
}
