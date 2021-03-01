import 'package:geolocator/geolocator.dart';

abstract class LokasiRepo {
  Future<Position> getLokasiData();
  Future<bool> checkGps();
  Future checkPermission();
}

class LokasiFunction implements LokasiRepo {
  bool isLocationEnabled = false;
  LocationPermission geolocationPermission;
  Position position;
  @override
  Future<Position> getLokasiData() async {
    position = await Geolocator.getCurrentPosition();
    print(position);
    return position;
  }

  //check gps aktif atau tidak
  Future<bool> checkGps() async {
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    print("check gps!");
    print(isLocationEnabled);
    return isLocationEnabled;
  }

  //check permisi gps
  Future checkPermission() async {
    geolocationPermission = await Geolocator.checkPermission();
    print(geolocationPermission);
    print("check permission!");
    if (geolocationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (geolocationPermission == LocationPermission.denied) {
      geolocationPermission = await Geolocator.requestPermission();
      if (geolocationPermission != LocationPermission.whileInUse &&
          geolocationPermission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $geolocationPermission).');
      }
    }
    return geolocationPermission;
  }
}
