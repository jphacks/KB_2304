import 'package:geolocator/geolocator.dart';
import 'package:hallo_world/map.dart';

class Station {
  final mapPageState = MapPageState();
  double? lati;
  double? longi;
  double? stationLati;
  double? stationLongi;
  double? distance;
  String? stationName;
  Station(String stationName, double stationLati, double stationLongi) {
    mapPageState.location();
    stationName = stationName;
    lati = mapPageState.lati;
    longi = mapPageState.longi;
    stationLati = stationLati;
    stationLongi = stationLongi;
    lati = 30;
    longi = 100;
    distance = Geolocator.distanceBetween(stationLati, stationLongi,
        mapPageState.getLati(), mapPageState.getLongi());
  }
  //距離計算、引数より短い距離にいるときtrueを返す
  checker(int checkerDistance) {
    if (distance! < checkerDistance) {
      return true;
    } else {
      return false;
    }
  }
}
