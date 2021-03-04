import 'package:flutter/material.dart';
import 'package:inventaris_app_ptpn1/Screen/detail_item.dart';
import 'package:inventaris_app_ptpn1/Screen/qrCode_screen.dart';
import 'package:sizer/sizer.dart';

class CardInventaris extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String nomor;

  CardInventaris({Key key, @required this.name, this.imageUrl, this.nomor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductsScreen(
                    slug: Urls.IMAGE_SUB_KATEGORI_URL + slug,
                    name: name,
                  )),
        ); */
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (imageUrl != null || imageUrl != "null")
                    ? Expanded(
                        flex: 1,
                        child: Image.network(
                          "http://192.168.100.33/inventaris/assets/image/" +
                              imageUrl,
                          width: 25.0.w,
                          height: 15.0.h,
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
                              width: 25.0.w,
                              height: 15.0.h,
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      )
                    : Expanded(
                        flex: 1,
                        child: Image.asset(
                          "assets/images/no-image.png",
                          width: 25.0.w,
                          height: 15.0.h,
                        ),
                      ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nama : " + name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto-Light.ttf',
                                fontSize: 11.0.sp)),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Text("Nomor : " + nomor,
                            textAlign: TextAlign.left,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto-Light.ttf',
                                fontSize: 11.0.sp)),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            buildElevatedButton(context, "Detail", nomor),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            buildElevatedButton(context, "QR Code", nomor)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(
          BuildContext context, String text, String nomorInventaris) =>
      ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (text == "Detail")
                      ? DetailScreen(
                          nomorInventaris: nomorInventaris,
                        )
                      : QrCodeScreen()));
        },
        child: Text(
          text,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          onPrimary: Colors.white,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      );
}
