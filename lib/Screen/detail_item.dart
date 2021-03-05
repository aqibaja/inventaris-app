import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventaris_app_ptpn1/Models/GetInventarisModel.dart';
import 'package:inventaris_app_ptpn1/Ulrs/Urls.dart';
import 'package:inventaris_app_ptpn1/bloc/inventaris_bloc.dart';
import 'package:inventaris_app_ptpn1/bloc/lokasi_bloc.dart';
import 'package:inventaris_app_ptpn1/bloc/service_dart_bloc.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd"); //format date time

class DetailScreen extends StatefulWidget {
  final String nomorInventaris;
  DetailScreen({this.nomorInventaris});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DateTime _date = DateTime.now();
  DateTime _dateService = DateTime.now();
  //String _date = dateFormat.format(DateTime.now());
  SimpleLocationResult _selectedLocation;
  File _image; //variabel untuk menyimpan image sementara
  final picker = ImagePicker(); //objeck picker untuk mengambil image
  bool isLocationEnabled = false;
  LocationPermission geolocationPermission;
  Position position;
  LokasiBloc _lokasiBloc;
  InventarisBloc _inventarisBloc;
  ServiceDartBloc _serviceDartBloc;
  String imageGet;

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

  Future<Null> selectedTimePicker(BuildContext context, String dateType) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (picked != null && picked != _date) {
      setState(() {
        if (dateType == "service") {
          _dateService = picked;
        } else {
          _date = picked;
        }
        _textEditNamaBarang = _textEditNamaBarang;
        _textEditNomorBarang = _textEditNomorBarang;
        print(_date.toString());
      });
    }
  }

  TextEditingController _textEditLocation = TextEditingController();
  TextEditingController _textEditNamaBarang = TextEditingController();
  TextEditingController _textEditNomorBarang = TextEditingController();
  TextEditingController _textEditDate = TextEditingController();
  TextEditingController _textEditService = TextEditingController();
  TextEditingController _textEditMutasi = TextEditingController();

  int selectedRadio = 0; // selected status

  @override
  Widget build(BuildContext context) {
    _lokasiBloc = BlocProvider.of<LokasiBloc>(context); //initial bloc lokasi
    _inventarisBloc = BlocProvider.of<InventarisBloc>(context);
    _serviceDartBloc = BlocProvider.of<ServiceDartBloc>(context);
    _lokasiBloc.add(ClearLokasiEvent());
    _textEditDate.text = dateFormat.format(_date);
    _textEditService.text = dateFormat.format(_dateService);
    _textEditMutasi.text = dateFormat.format(_dateService);
    _inventarisBloc.add(ClearEventInventaris());

    //watch state service
    ServiceDartState serviceDartState = context.watch<ServiceDartBloc>().state;

    setSelectedRadio(int val) {
      setState(() {
        print(val);
        selectedRadio = val;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: SingleChildScrollView(
          child: BlocBuilder<InventarisBloc, InventarisState>(
        builder: (context, state) {
          if (state is InventarisInitial) {
            _inventarisBloc.add(
                GetInventarisEvent(nomorInventaris: widget.nomorInventaris));
          }
          if (state is GetInventarisLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              EasyLoading.show(status: 'loading...');
            });
          }
          if (state is GetInventarisError) {
            print(state.error);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              EasyLoading.show(status: "Terjadi kesalahan");
            });
            Future.delayed(Duration(seconds: 3), () {
              EasyLoading.dismiss();
            });
          }
          if (state is GetInventarisSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              EasyLoading.showSuccess('Success!');
            });
            Future.delayed(Duration(seconds: 3), () {
              EasyLoading.dismiss();
            });

            GetInventarisModel detail = state.getInventarisModel;
            print(detail.id);
            _textEditNamaBarang.text = detail.namaBarang;
            _textEditNomorBarang.text = detail.nomorBarang;
            _textEditLocation.text = detail.lokasi;
            _textEditService.text = detail.tanggalService;
            _textEditMutasi.text = detail.tanggalMutasi;
            _textEditDate.text = dateFormat.format(detail.tanggalPembukuan);
            return Container(
              margin: EdgeInsets.only(right: 5.0.w, left: 5.0.w),
              child: Center(
                  child: Column(
                children: [
                  image(detail.image),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonSelect("Galery"),
                      buttonSelect("Camera"),
                    ],
                  ),
                  textField(
                      "Nama Barang", Icons.inventory, _textEditNamaBarang),
                  textField("Nomor Inventaris", FontAwesomeIcons.idCard,
                      _textEditNomorBarang),
                  datePickerTextField("Tanggal Pembukuan", Icons.date_range,
                      _textEditDate, "date"),
                  locationPicker(
                      "Lokasi", Icons.location_on_outlined, _textEditLocation),
                  buttonStatus((serviceDartState is ServiceState)
                      ? 1
                      : (serviceDartState is MutasiState)
                          ? 2
                          : 0),
                  BlocBuilder<ServiceDartBloc, ServiceDartState>(
                    builder: (context, state) {
                      if (state is ServiceState) {
                        return datePickerTextField(
                            "Tanggal Service",
                            Icons.miscellaneous_services_outlined,
                            _textEditService,
                            "service");
                      }
                      if (state is MutasiState) {
                        return datePickerTextField("Tanggal Mutasi",
                            Icons.move_to_inbox, _textEditMutasi, "service");
                      }
                      return Container();
                    },
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  BlocBuilder<InventarisBloc, InventarisState>(
                    builder: (context, state) {
                      if (state is AddInventarisLoading) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          EasyLoading.show(status: 'loading...');
                        });
                      }
                      if (state is AddInventarisSuccess) {
                        print("sukses!!");
                        if (state.addInventarisModel.success != "error") {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            EasyLoading.showSuccess('Great Success!');
                          });
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            EasyLoading.showError(
                                'Nomor Inventaris Sudah terdartar');
                          });
                        }
                        Future.delayed(Duration(seconds: 3), () {
                          EasyLoading.dismiss();
                        });
                      }
                      return buttonSave();
                    },
                  )
                ],
              )),
            );
          }
          if (state is GetInventarisFail) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              EasyLoading.showError('Nomor Inventaris Tidak Ditemukan');
            });
            Future.delayed(Duration(seconds: 3), () {
              EasyLoading.dismiss();
            });
          }
          return Container(
            margin: EdgeInsets.only(right: 5.0.w, left: 5.0.w),
            child: Center(
                child: Column(
              children: [
                image(""),
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
                datePickerTextField("Tanggal Pembukuan", Icons.date_range,
                    _textEditDate, "date"),
                locationPicker(
                    "Lokasi", Icons.location_on_outlined, _textEditLocation),
                buttonStatus((serviceDartState is ServiceState)
                    ? 1
                    : (serviceDartState is MutasiState)
                        ? 2
                        : 0),
                BlocBuilder<ServiceDartBloc, ServiceDartState>(
                  builder: (context, state) {
                    if (state is ServiceState) {
                      return datePickerTextField(
                          "Tanggal Service",
                          Icons.miscellaneous_services_outlined,
                          _textEditService,
                          "service");
                    }
                    if (state is MutasiState) {
                      return datePickerTextField("Tanggal Mutasi",
                          Icons.move_to_inbox, _textEditMutasi, "service");
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                BlocBuilder<InventarisBloc, InventarisState>(
                  builder: (context, state) {
                    if (state is AddInventarisLoading) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        EasyLoading.show(status: 'loading...');
                      });
                    }
                    if (state is AddInventarisSuccess) {
                      print("sukses!!");
                      if (state.addInventarisModel.success != "error") {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          EasyLoading.showSuccess('Great Success!');
                        });
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          EasyLoading.showError(
                              'Nomor Inventaris Sudah terdartar');
                        });
                      }
                      Future.delayed(Duration(seconds: 3), () {
                        EasyLoading.dismiss();
                      });
                    }
                    return buttonSave();
                  },
                )
              ],
            )),
          );
        },
      )),
    );
  }

  ButtonBar buttonStatus(int service) {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: service,
              activeColor: Colors.green,
              onChanged: (val) {
                print("Radio $val");
                _serviceDartBloc.add(SelectEventService(select: val));
                //setSelectedRadio(val);
              },
            ),
            Text('Service')
          ],
        ),
        Row(
          children: [
            Radio(
              value: 2,
              groupValue: service,
              activeColor: Colors.blue,
              onChanged: (val) {
                print("Radio $val");
                _serviceDartBloc.add(SelectEventService(select: val));
              },
            ),
            Text('Mutasi')
          ],
        ),
      ],
    );
  }

  //tombol save
  Widget buttonSave() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _inventarisBloc.add(AddInventarisEvent(
              namaBarang: _textEditNamaBarang.text,
              nomorBarang: _textEditNomorBarang.text,
              lokasi: _textEditLocation.text,
              image: _image,
              tanggalPembukuan: _textEditDate.text,
              latitude: _selectedLocation.latitude.toString(),
              longitude: _selectedLocation.longitude.toString(),
            ));
          },
          child: Text("SAVE"),
          style: ElevatedButton.styleFrom(
            primary: Colors.lightGreen, // background
            onPrimary: Colors.white, // foreground
          ),
        )
      ],
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
  Widget datePickerTextField(String label, IconData icon,
      TextEditingController _textEditDate, String dateType) {
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
                selectedTimePicker(context, dateType);
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

  Container image(String foto) {
    return Container(
      margin: EdgeInsets.only(top: 5.0.h),
      width: 45.0.w,
      height: 21.0.h,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
      child: (_image == null)
          ? (foto != "")
              ? Image.network(
                  Urls.ROOT_URL + foto,
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    // Appropriate logging or analytics, e.g.
                    // myAnalytics.recordError(
                    //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                    //   exception,
                    //   stackTrace,
                    // );
                    return Image.asset(
                      "assets/images/no-image.png",
                      fit: BoxFit.fill,
                    );
                  },
                )
              : Image.asset(
                  "assets/images/no-image.png",
                  fit: BoxFit.fill,
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
