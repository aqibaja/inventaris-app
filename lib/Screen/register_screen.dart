import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventaris_app_ptpn1/bloc/auth_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:email_validator/email_validator.dart';
import 'login_screen.dart';

class AppSingUp extends StatefulWidget {
  @override
  _AppSingUpState createState() => _AppSingUpState();
}

class _AppSingUpState extends State<AppSingUp> {
  int selectedRadio = 1;
  String gender = "laki-laki";
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _authBloc = BlocProvider.of<AuthBloc>(context); //init bloc
    //_authBloc.add(ClearEvent());

    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    setSelectedRadio(int val) {
      setState(() {
        print(val);
        selectedRadio = val;
        (val == 1) ? gender = "laki-laki" : gender = "perempuan";
        print(gender);
      });
    }

    TextEditingController _textEditingUsername = TextEditingController();
    TextEditingController _textEditingEmail = TextEditingController();
    TextEditingController _textEditingPhone = TextEditingController();
    TextEditingController _textEditingPassword = TextEditingController();
    TextEditingController _textEditingPassword2 = TextEditingController();
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
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 100,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/ptpn1-text.png",
                        fit: BoxFit.fitWidth,
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
                      controller: _textEditingUsername,
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
                        hintText: "Username",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Maaf data tidak boleh kosong';
                        } else if (EmailValidator.validate(value) == false) {
                          return 'Maaf format email salah';
                        }
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
                          Icons.mail,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "Email",
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
                      controller: _textEditingPhone,
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
                          Icons.phone,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "Phone Number",
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: selectedRadio,
                              activeColor: Colors.green,
                              onChanged: (val) {
                                print("Radio $val");
                                setSelectedRadio(val);
                              },
                            ),
                            Text('Pria')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: selectedRadio,
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                print("Radio $val");
                                setSelectedRadio(val);
                              },
                            ),
                            Text('Wanita')
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Maaf data tidak boleh kosong';
                              }
                              return null;
                            },
                            controller: _textEditingPassword,
                            obscureText: true,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: "Password",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Maaf data tidak boleh kosong';
                              } else if (value != _textEditingPassword.text) {
                                return 'Password tidak sama';
                              }
                              return null;
                            },
                            controller: _textEditingPassword2,
                            obscureText: true,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: "Konfirmasi Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      child:
                          /* BlocBuilder<AuthBloc, AuthState>(
                          builder: (BuildContext context, AuthState state) {
                        if (state is RegisterLoading) {
                          print("loading...");
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Sedang diproses...'),
                              duration: const Duration(seconds: 1),
                            ));
                          });
                        }
                        if (state is RegisterLoaded) {
                          print("sukses");
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
                                  builder: (context) => AppSignIn()),
                            );
                          });
                        }
                        if (state is RegisterFail) {
                          print("gagal");
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.registerModel.message),
                              duration: const Duration(seconds: 3),
                            ));
                          });
                        }
                        return  */
                          RaisedButton(
                        padding: EdgeInsets.all(17.0),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            /* _authBloc.add(RegisterEvent(
                                username: _textEditingUsername.text,
                                email: _textEditingEmail.text,
                                gender: gender,
                                noHp: _textEditingPhone.text,
                                password: _textEditingPassword.text,
                              )); */
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins-Medium.ttf',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.cyan,
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
                          "Already have an account? ",
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppSignIn()),
                          );
                        },
                        child: Container(
                          child: Text(
                            "Sign In",
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
}
