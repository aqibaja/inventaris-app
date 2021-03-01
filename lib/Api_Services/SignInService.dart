import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:inventaris_app_ptpn1/Models/SignInFailModel.dart';
import 'package:inventaris_app_ptpn1/Models/SignInModel.dart';

abstract class SignInRepo {
  Future<dynamic> getLoginData(String email, String password);
}

class SignInService implements SignInRepo {
  SignInModel signInData;
  SignInFailModel signInFailData;
  @override
  Future<dynamic> getLoginData(String email, String password) async {
    Map data = {
      'email': email,
      'password': password,
    };
    String bodyPost = json.encode(data);
    String url = ""; //Urls.SIGN_IN_URL;

    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 201) {
      signInData = SignInModel.fromJson(body);
      return signInData;
    } else if (statusCode == 400) {
      signInFailData = SignInFailModel.fromJson(body);
      return signInFailData;
    } else {
      return signInData;
    }
  }
}
