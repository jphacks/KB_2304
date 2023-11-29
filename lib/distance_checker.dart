// import 'dart:ffi';

import 'package:geolocator/geolocator.dart';
import 'package:hallo_world/map.dart';

class StationDistance {
  final mapPageState = MapPageState();
  double? lati;
  double? longi;
  double? stationLati;
  double? stationLongi;
  double? distance;
  String? stationName;
  // Station (String stationName, double stationLati, double stationLongi) async {
  // await mapPageState.location();
  // stationName = stationName;
  // lati = await mapPageState.getLati();
  // longi = await mapPageState.getLongi();
  // stationLati = stationLati;
  // stationLongi = stationLongi;
  //   print("station");
  //   print(stationLati);
  //   print("now");
  //   print(lati);
  //   distance =
  //       Geolocator.distanceBetween(stationLati, stationLongi, lati!, longi!);
  // }
  StationDistance(String stationName, double stationLati, double stationLongi) {
    this.stationName = stationName;
    this.stationLati = stationLati;
    this.stationLongi = stationLongi;
    getLocation(stationName, stationLati, stationLongi);
  }

  Future<double> getLocation(
      String stationName, double stationLati, double stationLongi) async {
    await mapPageState.location();
    lati = await mapPageState.getLati();
    longi = await mapPageState.getLongi();
    print("station");
    print(stationLati);
    print("now");
    print(lati);
    distance =
        Geolocator.distanceBetween(stationLati, stationLongi, lati!, longi!);
    print(distance);
    return distance!;
  }

  //距離計算、引数より短い距離にいるときtrueを返す
  checker(int checkerDistance) {
    if (distance == null) {
      getLocation("神戸三ノ宮", 34.694545, 135.195256);
      if (lati == null || longi == null) {
        lati = 34.694545;
        longi = 135.195256;
        getLocation("神戸三ノ宮", 34.694545, 135.195256);
        distance =
            Geolocator.distanceBetween(34.694545, 135.195256, lati!, longi!);
        print("1");
      } else {
        getLocation("神戸三ノ宮", 34.694545, 135.195256);
        distance = 100;
        print("2");
      }
      if (distance! < checkerDistance) {
        return true;
      } else {
        return false;
      }
    } else {
      print(distance);
      getLocation("神戸三ノ宮", 34.694545, 135.195256);
      distance =
          Geolocator.distanceBetween(34.694545, 135.195256, lati!, longi!);
      print("lati");
      print(lati);
      print("判定");
      print(distance);
      print(checkerDistance);
      if (distance! < checkerDistance) {
        return true;
      } else {
        return false;
      }
    }
  }
}