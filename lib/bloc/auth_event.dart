part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String gender;
  final String email;
  final String noHp;
  RegisterEvent(
      {this.username, this.password, this.email, this.gender, this.noHp});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({this.password, this.email});
}

class CheckLoginEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}

class ClearEvent extends AuthEvent {}
