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
                    )
                  : Image.asset(
                      "assets/images/no-image.png",
                      width: 15.5.w,
                      height: 7.5.h,
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
                            fontSize: 11.0.sp))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
