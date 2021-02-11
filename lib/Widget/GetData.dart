import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventaris_app_ptpn1/Models/inventarisModel.dart';
import 'package:http/http.dart';
import 'package:inventaris_app_ptpn1/Ulrs/Urls.dart';
import 'package:inventaris_app_ptpn1/Widget/CircularProgress.dart';
import 'package:inventaris_app_ptpn1/Widget/GridTilesInventaris.dart';

//class list item
class GetWidget extends StatelessWidget {
  final String slug;

  GetWidget({Key key, this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getItemList(slug),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgress();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );
  }
}

//widget list view
Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<InventarisModel> results = snapshot.data;
  return ListView.builder(
      shrinkWrap: true, //agar bisa masuk di column
      physics: NeverScrollableScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, i) {
        return CardInventaris(
          name: results[i].namaBarang,
          imageUrl: results[i].image,
          nomor: results[i].nomorBarang,
        );
      });
}

List<InventarisModel> inventarisItems; //objeck yg berisi list item

//get data json
Future<List<InventarisModel>> getItemList(String slug) async {
  inventarisItems = null;
  if (inventarisItems == null) {
    Response response;
    response = await get(Urls.ALL_INVENTARIS_URL + slug);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      inventarisItems =
          (body as List).map((i) => InventarisModel.fromJson(i)).toList();
      return inventarisItems;
    } else {
      return inventarisItems;
    }
  } else {
    return inventarisItems;
  }
}
