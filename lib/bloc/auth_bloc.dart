import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventaris_app_ptpn1/Api_Services/SignInService.dart';
import 'package:inventaris_app_ptpn1/Api_Services/SignUpService.dart';
import 'package:inventaris_app_ptpn1/Models/SignInFailModel.dart';
import 'package:inventaris_app_ptpn1/Models/SignInModel.dart';
import 'package:inventaris_app_ptpn1/Models/SignUpModel.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignUpModel data;
  SignInModel dataSignIn;
  SharedPreferences sharedPreferences;
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterEvent) {
      try {
        yield SignUpLoading();
        //Future.delayed(Duration(seconds: 2));
        data = await SignUpService().getRegisterData(event.username,
            event.email, event.gender, event.password, event.noHp);

        yield SignUpSuccess(signUpModel: data);
      } catch (e) {
        SignUpError(error: e.toString());
      }
    } else if (event is LoginEvent) {
      try {
        yield SignInLoading();
        //Future.delayed(Duration(seconds: 2));
        var data =
            await SignInService().getLoginData(event.email, event.password);
        if (data.success == true) {
          yield SignInSuccess(signInModel: data);
        }
        yield SignInFail(signInFailModel: data);
      } catch (e) {
        SignInError(error: e.toString());
      }
    }
    //check save login in memory
    else if (event is CheckLoginEvent) {
      //check shared info
      sharedPreferences = await SharedPreferences.getInstance();
      var data = sharedPreferences.get('id_user');
      print(data);
      if (data != null) {
        yield SignInSaved(idUSerSave: data);
      } else {
        yield SignInOut();
      }
    }
    // logout event
    else if (event is LogOutEvent) {
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      yield SignInOut();
    } else //clear state
    if (event is ClearEvent) {
      yield AuthInitial();
    }
  }
}
