import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventaris_app_ptpn1/bloc/lokasi_bloc.dart';
import 'package:inventaris_app_ptpn1/function/get_location.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:simple_location_picker/utils/slp_constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

String location = '(${4.487710}, ${97.943975})';

class _AddItemState extends State<AddItem> {
  DateTime _date = DateTime.now();
  SimpleLocationResult _selectedLocation;
  File _image; //variabel untuk menyimpan image sementara
  final picker = ImagePicker(); //objeck picker untuk mengambil image
  bool isLocationEnabled = false;
  LocationPermission geolocationPermission;
  Position position;
  LokasiBloc _lokasiBloc;

  //method menyambil image di camera
  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //method menyambil image di galery
  Future getImageGalery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Null> selectedTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _textEditNamaBarang = _textEditNamaBarang;
        _textEditNomorBarang = _textEditNomorBarang;
        print(_date.toString());
      });
    }
  }

  TextEditingController _textEditLocation = TextEditingController();
  TextEditingController _textEditNamaBarang = TextEditingController();
  TextEditingController _textEditNomorBarang = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _lokasiBloc = BlocProvider.of<LokasiBloc>(context); //initial bloc lokasi
    _lokasiBloc.add(ClearLokasiEvent());
    TextEditingController _textEditDate = TextEditingController(
      text: _date.day.toString() +
          " / " +
          _date.month.toString() +
          " / " +
          _date.year.toString(),
    );
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(right: 5.0.w, left: 5.0.w),
        child: Center(
            child: Column(
          children: [
            image(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonSelect("Galery"),
                buttonSelect("Camera"),
              ],
            ),
            textField("Nama Barang", Icons.inventory, _textEditNamaBarang),
            textField("Nomor Inventaris", FontAwesomeIcons.idCard,
                _textEditNomorBarang),
            datePickerTextField("Tanggal", Icons.date_range, _textEditDate),
            locationPicker(
                "Lokasi", Icons.location_on_outlined, _textEditLocation),
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("SAVE"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen, // background
                    onPrimary: Colors.white, // foreground
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }

  //check gps aktif atau tidak
  Future checkGps() async {
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    print("check gps!");
    print(isLocationEnabled);
  }

  //check permisi gps
  Future checkPermission() async {
    geolocationPermission = await Geolocator.checkPermission();
    print(geolocationPermission);
    print("check permission!");
    if (geolocationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (geolocationPermission == LocationPermission.denied) {
      geolocationPermission = await Geolocator.requestPermission();
      if (geolocationPermission != LocationPermission.whileInUse &&
          geolocationPermission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $geolocationPermission).');
      }
    }
    position = await Geolocator.getCurrentPosition();
    print(position);
  }

  //lokasi
  Widget locationPicker(
      String label, IconData icon, TextEditingController _textEditLocation) {
    return Container(
      margin: EdgeInsets.only(left: 1.0.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _textEditLocation,
              maxLines: 3,
              // focusNode: _passwordEmail,
              //keyboardType: TextInputType.emailAddress,
              //textInputAction: TextInputAction.next,
              //validator: _validateEmail,
              onFieldSubmitted: (String value) {
                //FocusScope.of(context).requestFocus(_passwordFocus);
              },
              decoration: InputDecoration(
                  labelText: label,
                  //prefixIcon: Icon(Icons.email),
                  icon: Icon(
                    icon,
                    size: 7.0.w,
                  )),
            ),
          ),
          BlocBuilder<LokasiBloc, LokasiState>(
            builder: (context, state) {
              if (state is CheckGps) {
                if (state.gps == false) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Tidak bisa menemukan lokasi"),
                        content: const Text('Tolong pastikan GPS aktif!'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }
              if (state is CheckPermission) {
                if (state.permission == LocationPermission.denied ||
                    state.permission == LocationPermission.deniedForever) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Tidak bisa menemukan lokasi"),
                        content:
                            const Text('Tolong izinkan permintaan lokasi!'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }
              if (state is LokasiSukses) {
                print("sukses lokasi" + state.lokasi.toString());
                double latitude = state.lokasi.latitude;
                double longitude = state.lokasi.longitude;

                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SimpleLocationPicker(
                                initialLatitude: latitude,
                                initialLongitude: longitude,
                                zoomLevel: 16,
                                appBarTitle: "Select Location",
                              ))).then((value) {
                    if (value != null) {
                      _selectedLocation = value;
                      placeCheck(_selectedLocation.latitude,
                          _selectedLocation.longitude);
                    }
                  });
                });
              }
              return Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    _lokasiBloc.add(CheckLokasiEvent());
                  },
                  child: Text("Pilih Lokasi"),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future placeCheck(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    setState(() {
      _textEditLocation.text =
          "${place.subThoroughfare},${place.thoroughfare},${place.subLocality},${place.locality},${place.administrativeArea},${place.country}";
      ;
      _lokasiBloc.add(ClearLokasiEvent());
    });
    return placemarks;
  }

  //mengambil tanggal
  Widget datePickerTextField(
      String label, IconData icon, TextEditingController _textEditDate) {
    return Container(
      margin: EdgeInsets.only(left: 1.0.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _textEditDate,
              // focusNode: _passwordEmail,
              //keyboardType: TextInputType.emailAddress,
              //textInputAction: TextInputAction.next,
              //validator: _validateEmail,
              onFieldSubmitted: (String value) {
                //FocusScope.of(context).requestFocus(_passwordFocus);
              },
              decoration: InputDecoration(
                  labelText: label,
                  //prefixIcon: Icon(Icons.email),
                  icon: Icon(
                    icon,
                    size: 7.0.w,
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                selectedTimePicker(context);
              },
              child: Text("Pilih Tanggal"),
            ),
          )
        ],
      ),
    );
  }

  Container textField(
      String label, IconData icon, TextEditingController _textController) {
    return Container(
      margin: EdgeInsets.only(left: 1.0.w),
      child: TextFormField(
        controller: _textController,
        // focusNode: _passwordEmail,
        // keyboardType: TextInputType.emailAddress,
        // textInputAction: TextInputAction.next,
        //validator: _validateEmail,
        onFieldSubmitted: (String value) {},
        decoration: InputDecoration(
            labelText: label,
            //prefixIcon: Icon(Icons.email),
            icon: Icon(
              icon,
              size: 7.0.w,
            )),
      ),
    );
  }

  //pilih galery atau camera
  Widget buttonSelect(String from) {
    return Container(
      margin: EdgeInsets.only(top: 1.0.h, right: 1.0.h, left: 1.0.h),
      child: RaisedButton(
        onPressed: () {
          from == "Camera" ? getImageCamera() : getImageGalery();
        },
        child: Text(from),
      ),
    );
  }

  Container image() {
    return Container(
      margin: EdgeInsets.only(top: 5.0.h),
      width: 45.0.w,
      height: 21.0.h,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
      child: (_image == null)
          ? Icon(
              Icons.image,
              size: 35.0.w,
            )
          : Image.file(
              _image,
              height: 35.0.w,
              width: 35.0.w,
              fit: BoxFit.fill,
            ),
    );
  }
}
