part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//ketika data sedang loading
class RegisterLoading extends AuthState {}

//ketika data ter load
class RegisterLoaded extends AuthState {
  final RegisterModel registerModel;
  RegisterLoaded({this.registerModel});
}

//ketika data ter load
class RegisterFail extends AuthState {
  final RegisterModel registerModel;
  RegisterFail({this.registerModel});
}

//ketika data error
class RegisterError extends AuthState {
  final error;
  RegisterError({this.error});
}

//data api login selesai di get
class LoginSuccess extends AuthState {
  final LoginModel signInModel;
  LoginSuccess({this.signInModel});
}

class LoginFail extends AuthState {
  final LoginFailModel signInFailModel;
  LoginFail({this.signInFailModel});
}

class LoginSaved extends AuthState {
  final String apiToken;
  LoginSaved({this.apiToken});
}

class LoginOut extends AuthState {
  //final SignInModel signInModel;
  /* SignInProcess({this.signInModel}); */
}

class LoginLoading extends AuthState {}

class LoginError extends AuthState {
  final String error;
  LoginError({this.error});
}
