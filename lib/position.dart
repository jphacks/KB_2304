import 'package:geolocator/geolocator.dart';

class GetLocation {
  static int? lati;
  static int? longi;
  static Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lati = position.latitude as int?;
    longi = position.longitude as int?;
    return position;
  }
}
