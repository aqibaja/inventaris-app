/* import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("history"),
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:simple_location_picker/utils/slp_constants.dart';

class History extends StatefulWidget {
  History({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  SimpleLocationResult _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),

          // The button that opens the SimpleLocationPicker in display ONLY mode.
          // This opens the SimpleLocationPicker to display a specific location on the map with a marker.
          RaisedButton(
            child: Text("Display a location"),
            onPressed: () {
              double latitude = _selectedLocation != null
                  ? _selectedLocation.latitude
                  : SLPConstants.DEFAULT_LATITUDE;
              double longitude = _selectedLocation != null
                  ? _selectedLocation.longitude
                  : SLPConstants.DEFAULT_LONGITUDE;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SimpleLocationPicker(
                            initialLatitude: 5.535434, //latitude,
                            initialLongitude: 95.270680, //longitude,
                            //zoomLevel: 19,
                            appBarTitle: "Display Location",
                            displayOnly: true,
                          )));
            },
          ),
          SizedBox(height: 50),

          // The button that opens the SimpleLocationPicker in picker mode.
          // This opens the SimpleLocationPicker to allow the user to pick a location from the map.
          // The SimpleLocationPicker returns SimpleLocationResult containing the lat, lng of the picked location.
          RaisedButton(
            child: Text("Pick a Location"),
            onPressed: () {
              double latitude = _selectedLocation != null
                  ? _selectedLocation.latitude
                  : SLPConstants.DEFAULT_LATITUDE;
              double longitude = _selectedLocation != null
                  ? _selectedLocation.longitude
                  : SLPConstants.DEFAULT_LONGITUDE;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SimpleLocationPicker(
                            initialLatitude: 4.487710,
                            initialLongitude: 97.943975,
                            appBarTitle: "Select Location",
                          ))).then((value) {
                if (value != null) {
                  setState(() {
                    _selectedLocation = value;
                  });
                }
              });
            },
          ),

          SizedBox(height: 50),
          // Displays the picked location on the screen as text.
          _selectedLocation != null
              ? Text(
                  'SELECTED: (${_selectedLocation.latitude}, ${_selectedLocation.longitude})')
              : Container(),
        ],
      ),
    );
  }
}
