import 'package:flutter/material.dart';
import 'package:inventaris_app_ptpn1/Widget/GetDataAll.dart';
import 'package:sizer/sizer.dart';

final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
List<String> items = [];

class AllItem extends StatefulWidget {
  @override
  _AllItemState createState() => _AllItemState();
}

class _AllItemState extends State<AllItem> {
  TextEditingController editingController = TextEditingController();

  //fungsi search
  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GetWidgetAll(
                slug: "inventaris",
              ),
            ),
          )
        ],
      )),
    );
  }
}
