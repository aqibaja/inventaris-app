import 'package:flutter/material.dart';
import 'package:inventaris_app_ptpn1/Ulrs/Urls.dart';
import 'package:sizer/sizer.dart';

class QrCodeScreen extends StatelessWidget {
  final String qrCodeUrl;
  QrCodeScreen({this.qrCodeUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Code Detail"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 50.0.w,
                  width: 50.0.w,
                  child: Image.network(
                    Urls.STORAGE_URL + qrCodeUrl,
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
                  )),
              SizedBox(
                height: 5.0.h,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    width: 45.0.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code,
                          size: 10.0.w,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Print Label",
                          style: TextStyle(fontSize: 15.0.sp),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
