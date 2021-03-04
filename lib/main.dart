import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventaris_app_ptpn1/Screen/login_screen.dart';
import 'package:inventaris_app_ptpn1/bloc/inventaris_bloc.dart';
import 'package:inventaris_app_ptpn1/bloc/lokasi_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inventaris_app_ptpn1/bloc/service_dart_bloc.dart';
import 'main_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //return LayoutBuilder
      builder: (context, constraints) {
        return OrientationBuilder(
          //return OrientationBuilder
          builder: (context, orientation) {
            //initialize SizerUtil()
            SizerUtil().init(constraints, orientation); //initialize SizerUtil
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => LokasiBloc()),
                BlocProvider(create: (context) => InventarisBloc()),
                BlocProvider(create: (context) => ServiceDartBloc()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Sizer',
                theme: ThemeData(primaryColor: Colors.lightGreen),
                home: AppSignIn(),
                builder: EasyLoading.init(),
              ),
            );
          },
        );
      },
    );
  }
}
