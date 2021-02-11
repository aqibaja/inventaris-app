import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScanInventaris extends StatelessWidget {
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
              onPressed: () {},
              child: Text("Scan Now"),
              color: Colors.greenAccent[100],
            )
          ],
        ),
      ),
    );
  }
}
