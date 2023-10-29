import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hallo_world/distance_checker.dart';
import 'package:hallo_world/notification.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  double? lati;
  double? longi;
  // Station station = Station('三ノ宮', 34.6945454, 135.1952558);
  // TODO getStationクラスを作る
  LatLng stationCenter = LatLng(34.6945454, 135.1952558);
  //ウィジェットが最初に作成されたときに呼び出されるメソッド。latiとlongiを初期化するために使う。
  @override
  void initState() {
    super.initState();
    location().then((position) {
      setState(() {
        lati = position.latitude;
        longi = position.longitude;
      });
    });
  }

  Future<Position> location() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 位置情報サービスが有効かどうかをテストします。
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 位置情報サービスが有効でない場合、続行できません。
      // 位置情報にアクセスし、ユーザーに対して
      // 位置情報サービスを有効にするようアプリに要請する。
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // ユーザーに位置情報を許可してもらうよう促す
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 拒否された場合エラーを返す
        return Future.error('Location permissions are denied');
      }
    }

    // 永久に拒否されている場合のエラーを返す
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // ここまでたどり着くと、位置情報に対しての権限が許可されているということなので
    // デバイスの位置情報を返す。
    return await Geolocator.getCurrentPosition();
  }

  //緯度経度の設定。もし緯度経度がnullだったら、 神戸三ノ宮駅の緯度経度を設定する。
  LatLng get _center => lati != null && longi != null
      ? LatLng(lati!, longi!)
      : const LatLng(34.6945454, 135.1952558);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  double getLati() {
    if (lati == null) {
      return lati!;
    }else{
      return lati!;
    }
  }

  double getLongi() {
    if (longi == null) {
      return longi!;
    }else{
      return longi!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map！！！！！！！！！'),
          backgroundColor: Color.fromARGB(255, 235, 159, 7),
        ),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          circles: {
            Circle(
              circleId: CircleId('circle_1'),
              center: stationCenter,
              radius: 1000,
              fillColor: Colors.blue.withOpacity(0.5),
              strokeColor: Colors.blue,
              strokeWidth: 2,
            ),
          },
        ),
      ),
    );
  }
}
