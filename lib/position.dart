import 'package:geolocator/geolocator.dart';
import 'package:hallo_world/map.dart';

class GetLocation {
  final mapPageState = MapPageState();
  double? lati;
  double? longi;
  GetLocation() {
    mapPageState.location();
    lati = mapPageState.lati;
    longi = mapPageState.longi;
  }
}
