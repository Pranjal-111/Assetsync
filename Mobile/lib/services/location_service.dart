import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openAppSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

Future<String> decodeLocation(double latitude, double longitude) async {
  String s = "Location Not Updated";
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
  var pl = placemarks[0];
  s = "${pl.name}, ${pl.street}, ${pl.subLocality}, ${pl.locality}, ${pl.subAdministrativeArea}, ${pl.administrativeArea}, Postal Code: ${pl.postalCode}";
  return s;
}
