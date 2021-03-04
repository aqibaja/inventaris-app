import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inventaris_app_ptpn1/Screen/detail_item.dart';
import 'package:sizer/sizer.dart';

class ScanInventaris extends StatefulWidget {
  @override
  _ScanInventarisState createState() => _ScanInventarisState();
}

class _ScanInventarisState extends State<ScanInventaris> {
  String qrCodeResult = 'Tidak diketahui';

  Future<void> qrCodeScanner() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel", true, ScanMode.QR);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(nomorInventaris: qrCode)));
    } on PlatformException {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        EasyLoading.showError('Terjadi kesalahan');
      });
      Future.delayed(Duration(seconds: 3), () {
        EasyLoading.dismiss();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.qr_code_scanner_rounded,
              size: 75.0.w,
            ),
            RaisedButton(
              onPressed: () => qrCodeScanner(),
              child: Text("Scan Now"),
              color: Colors.greenAccent[100],
            )
          ],
        ),
      ),
    );
  }
}
