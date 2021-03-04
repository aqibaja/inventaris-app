import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventaris_app_ptpn1/Api_Services/login_service.dart';
import 'package:inventaris_app_ptpn1/Api_Services/register_service.dart';
import 'package:inventaris_app_ptpn1/Models/login_fail_models.dart';
import 'package:inventaris_app_ptpn1/Models/login_models.dart';
import 'package:inventaris_app_ptpn1/Models/register_models.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterRepo registerRepo;
  final LoginRepo loginRepo;
  SharedPreferences sharedPreferences;
  AuthBloc({this.registerRepo, this.loginRepo}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterEvent) {
      try {
        yield RegisterLoading();
        //Future.delayed(Duration(seconds: 2));
        var data = await registerRepo.getRegisterData(event.username,
            event.email, event.gender, event.password, event.noHp);
        if (data.success == false) {
          yield RegisterFail(registerModel: data);
        } else {
          yield RegisterLoaded(registerModel: data);
        }
      } catch (e) {
        RegisterError(error: e.toString());
      }
    }
    if (event is LoginEvent) {
      try {
        yield LoginLoading();
        //Future.delayed(Duration(seconds: 2));
        var data =
            await LoginServices().getLoginData(event.email, event.password);

        if (data.success == false) {
          yield LoginFail(signInFailModel: data);
        } else {
          yield LoginSuccess(signInModel: data);
        }
      } catch (e) {
        RegisterError(error: e.toString());
      }
    }
    //clear state
    if (event is ClearEvent) {
      yield AuthInitial();
    }
    //check save login in memory
    if (event is CheckLoginEvent) {
      //check shared info
      sharedPreferences = await SharedPreferences.getInstance();
      var data = sharedPreferences.get('api_token');
      print(data);
      if (data != null) {
        yield LoginSaved(apiToken: data);
      } else {
        yield LoginOut();
      }
    }
    // logout event
    if (event is LogOutEvent) {
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      yield LoginOut();
    }
  }
}
