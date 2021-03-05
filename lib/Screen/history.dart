import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  History({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HistoryState createState() => _HistoryState();
}

DateTime _date = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
String formatted = formatter.format(_date);

TextStyle textStyle = TextStyle(fontSize: 19.0.sp);

class _HistoryState extends State<History> {
  TextEditingController _textEditDate = TextEditingController(text: formatted);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 3.0.h,
          ),
          Container(
            child: Center(
              child: Text(
                "History",
                style: TextStyle(fontSize: 25.0.sp),
              ),
            ),
          ),
          Container(
            child: datePickerTextField(
                "Tanggal", Icons.date_range, _textEditDate, context),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          _buildRow(
              "Kursi",
              "1111122223333333333333333333333333333333",
              "Service",
              'http://192.168.100.33/inventaris/public/upload/user/U-kursi.jpg'),
          SizedBox(
            height: 2.0.h,
          ),
          _buildRow("Meja laci", "122222233333333", "Mutasi",
              'http://192.168.100.33/inventaris/public/upload/user/U-1614652742.jpg'),
          SizedBox(
            height: 2.0.h,
          ),
          _buildRow("Meja laci", "5555555555555", "New",
              'http://192.168.100.33/inventaris/public/upload/user/U-1614652742.jpg'),
          /* Row(
            children: [
              ListTile(
                  leading: SizedBox(
                height: 100.0,
                width: 100.0,
                child: Image.network(
                  'http://192.168.100.33/inventaris/public/upload/user/U-1614652742.jpg',
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
                ),
              ))
            ], 
          ),*/
        ],
      ),
    );
  }

  Future<Null> selectedTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (picked != null && picked != _date) {
      setState(() {
        _textEditDate.text = formatter.format(picked);
        print(formatted);
      });
    }
  }

  Widget _buildRow(String name, String nomor, String status, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 15.0.w,
            width: 15.0.w,
            child: Image.network(
              imageUrl,
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
            ),
          ),
          SizedBox(
            width: 3.0.w,
          ),
          Container(
            height: 15.0.w,
            width: 50.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 19.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  nomor,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Center(
              child: Text(status,
                  style: TextStyle(
                      fontSize: 13.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            ),
          )
        ],
      ),
    );
  }

//mengambil tanggal
  Widget datePickerTextField(String label, IconData icon,
      TextEditingController _textEditDate, BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
        primaryColorDark: Colors.red,
      ),
      child: Container(
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
                    labelStyle: TextStyle(fontSize: 17.0.sp),
                    //prefixIcon: Icon(Icons.email),
                    icon: IconButton(
                      onPressed: () {
                        selectedTimePicker(context);
                      },
                      icon: Icon(
                        icon,
                        size: 7.0.w,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
