import 'package:flutter/material.dart';
import 'package:inventaris_app_ptpn1/Screen/add_item.dart';
import 'package:inventaris_app_ptpn1/Screen/history.dart';
import 'package:inventaris_app_ptpn1/Screen/scan_inventaris.dart';
import 'package:sizer/sizer.dart';

import 'Screen/all_item.dart';
import 'Screen/profile_user.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //list halaman
  int currentTap = 0;
  final List<Widget> screen = [
    ScanInventaris(),
    AddItem(),
    AllItem(),
    History(),
    Profile()
  ];

  //screen yang aktif
  Widget currentScreen = AddItem(); // yang pertama ketika hidup

  //object bucket
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inventaris PTPN 1",
          style: TextStyle(
              color: Colors.black,
              fontSize: 21.0.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: PageStorage(bucket: bucket, child: currentScreen),
      //tombol tengah
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentScreen = ScanInventaris();
            currentTap = 0;
          });
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(
          Icons.qr_code_outlined,
          size: 10.0.w,
        ),
      ),
      //arahkan ke tengah tombol scannya
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //resizeToAvoidBottomPadding: false, //agar floating action button tidak bergerak ketika keyboard hidup
      resizeToAvoidBottomInset: false,
      //bar bawah
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 8.0.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildMaterialButton(1, Icons.post_add_outlined, AddItem()),
              buildMaterialButton(2, Icons.inventory, AllItem()),
              SizedBox(
                width: 7.0.h,
              ),
              buildMaterialButton(3, Icons.history, History()),
              buildMaterialButton(4, Icons.person, Profile()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMaterialButton(int current, IconData icon, Widget screen) {
    return MaterialButton(
      highlightColor: Colors.transparent,
      onPressed: () {
        setState(() {
          currentScreen = screen;
          currentTap = current;
        });
      },
      child: Column(
        children: [
          SizedBox(
            height: 1.0.h,
          ),
          Icon(
            icon,
            size: 10.5.w,
            color: (currentTap == current) ? Colors.orangeAccent : Colors.grey,
          ),
        ],
      ),
    );
  }
}
