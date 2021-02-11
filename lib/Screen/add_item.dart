import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  DateTime _date = DateTime.now();

  Future<Null> selectedTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        print(_date.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditDate = TextEditingController(
      text: _date.day.toString() +
          " / " +
          _date.month.toString() +
          " / " +
          _date.year.toString(),
    );
    TextEditingController _textEditLocation = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(right: 5.0.w, left: 5.0.w),
        child: Center(
            child: Column(
          children: [
            image(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonSelect("Galery"),
                buttonSelect("Camera"),
              ],
            ),
            textField("Nama Barang", Icons.inventory),
            textField("Nomor Inventaris", FontAwesomeIcons.idCard),
            datePickerTextField("Tanggal", Icons.date_range, _textEditDate),
            locationPicker(
                "Lokasi", Icons.location_on_outlined, _textEditLocation),
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("SAVE"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen, // background
                    onPrimary: Colors.white, // foreground
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }

  //lokasi
  Widget locationPicker(
      String label, IconData icon, TextEditingController _textEditLocation) {
    return Container(
      margin: EdgeInsets.only(left: 1.0.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _textEditLocation,
              // focusNode: _passwordEmail,
              //keyboardType: TextInputType.emailAddress,
              //textInputAction: TextInputAction.next,
              //validator: _validateEmail,
              onFieldSubmitted: (String value) {
                //FocusScope.of(context).requestFocus(_passwordFocus);
              },
              decoration: InputDecoration(
                  labelText: label,
                  //prefixIcon: Icon(Icons.email),
                  icon: Icon(
                    icon,
                    size: 7.0.w,
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                selectedTimePicker(context);
              },
              child: Text("Pilih Lokasi"),
            ),
          )
        ],
      ),
    );
  }

  //mengambil tanggal
  Widget datePickerTextField(
      String label, IconData icon, TextEditingController _textEditDate) {
    return Container(
      margin: EdgeInsets.only(left: 1.0.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _textEditDate,
              // focusNode: _passwordEmail,
              //keyboardType: TextInputType.emailAddress,
              //textInputAction: TextInputAction.next,
              //validator: _validateEmail,
              onFieldSubmitted: (String value) {
                //FocusScope.of(context).requestFocus(_passwordFocus);
              },
              decoration: InputDecoration(
                  labelText: label,
                  //prefixIcon: Icon(Icons.email),
                  icon: Icon(
                    icon,
                    size: 7.0.w,
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                selectedTimePicker(context);
              },
              child: Text("Pilih Tanggal"),
            ),
          )
        ],
      ),
    );
  }

  Container textField(String label, IconData icon) {
    return Container(
      margin: EdgeInsets.only(left: 1.0.w),
      child: TextFormField(
        //controller: _textEditConEmail,
        // focusNode: _passwordEmail,
        // keyboardType: TextInputType.emailAddress,
        // textInputAction: TextInputAction.next,
        //validator: _validateEmail,
        onFieldSubmitted: (String value) {
          //FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: label,
            //prefixIcon: Icon(Icons.email),
            icon: Icon(
              icon,
              size: 7.0.w,
            )),
      ),
    );
  }

  //pilih galery atau camera
  Widget buttonSelect(String from) {
    return Container(
      margin: EdgeInsets.only(top: 1.0.h, right: 1.0.h, left: 1.0.h),
      child: RaisedButton(
        onPressed: () {},
        child: Text(from),
      ),
    );
  }

  Container image() {
    return Container(
      margin: EdgeInsets.only(top: 5.0.h),
      width: 45.0.w,
      height: 21.0.h,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
      child: Icon(
        Icons.image,
        size: 35.0.w,
      ),
    );
  }
}
