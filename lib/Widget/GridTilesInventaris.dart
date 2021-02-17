import 'package:flutter/material.dart';
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (imageUrl != null || imageUrl != "null")
                  ? Image.network(
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
                        return Image.asset("assets/images/no-image.png");
                      },
                    )
                  : Image.asset(
                      "assets/images/no-image.png",
                      width: 25.0.w,
                      height: 15.0.h,
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama : " + name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto-Light.ttf',
                            fontSize: 11.0.sp)),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Text("Nomor : " + nomor,
                        textAlign: TextAlign.center,
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
                        buildElevatedButton("Edit"),
                        SizedBox(
                          width: 2.0.w,
                        ),
                        buildElevatedButton("Print QR Code")
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(String text) => ElevatedButton(
        onPressed: () {},
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
