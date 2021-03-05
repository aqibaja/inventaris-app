import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventaris_app_ptpn1/Models/login_models.dart';
import 'package:inventaris_app_ptpn1/Screen/register_screen.dart';
import 'package:inventaris_app_ptpn1/bloc/auth_bloc.dart';
import 'package:inventaris_app_ptpn1/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSignIn extends StatefulWidget {
  @override
  _AppSignInState createState() => _AppSignInState();
}

class _AppSignInState extends State<AppSignIn> {
  AuthBloc _authBloc;
  //ShareInfo shareInfo;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_authBloc = BlocProvider.of<AuthBloc>(context); //init bloc
    //_authBloc.add(CheckLoginEvent());
    //_authBloc.add(ClearEvent());
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    TextEditingController _textEditingEmail = TextEditingController();
    TextEditingController _textEditingPassword = TextEditingController();
    final _formKey = GlobalKey<FormState>(); // key vallidation form

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 150,
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/ptpn1-text.png"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Maaf data tidak boleh kosong';
                        }
                        /* else if (EmailValidator.validate(value) == false) {
                          return 'Maaf format email salah';
                        } */
                        return null;
                      },
                      controller: _textEditingEmail,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "NIP",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Maaf data tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _textEditingPassword,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                        ),
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child:
                          /* BlocBuilder<AuthBloc, AuthState>(
                          builder: (BuildContext context, AuthState state) {
                        if (state is LoginSaved) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Sudah Login...'),
                              duration: const Duration(seconds: 1),
                            ));
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                            );
                          });
                        }
                        if (state is LoginLoading) {
                          print("loading...");
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Sedang diproses...'),
                              duration: const Duration(seconds: 1),
                            ));
                          });
                        }
                        if (state is LoginSuccess) {
                          print(
                              "api_token = " + state.signInModel.data.apiToken);
                          shareLoginSave(state.signInModel);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Sukses'),
                              duration: const Duration(seconds: 1),
                            ));
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                            );
                          });
                        }
                        if (state is LoginFail) {
                          print("gagal");
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.signInFailModel.message),
                              duration: const Duration(seconds: 3),
                            ));
                          });
                        } */
                          RaisedButton(
                        padding: EdgeInsets.all(17.0),
                        onPressed: () {
                          //dihapus dulu blom perlu
                          if (_formKey.currentState.validate()) {
                            /* _authBloc.add(LoginEvent(
                                email: _textEditingEmail.text,
                                password: _textEditingPassword.text,
                              )); */
                            if (_textEditingEmail.text == "admin" &&
                                _textEditingPassword.text == "admin") {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text('Sukses'),
                                  duration: const Duration(seconds: 1),
                                ));
                              });
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()),
                                    (route) => false);
                              });
                            }
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins-Medium.ttf',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.black)),
                      ),
                      /*  }), */
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppSingUp()),
                          )
                        },
                        child: Container(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFFAC252B),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //save  info logged in to shared preferences
  void shareLoginSave(LoginModel signInModel) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("api_token", signInModel.data.apiToken);
  }
}
