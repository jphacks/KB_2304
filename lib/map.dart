import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  double? lati;
  double? longi;
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

  LatLng get _center => lati != null && longi != null
      ? LatLng(lati!, longi!)
      : const LatLng(34.6945454, 135.1952558);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
        ),
      ),
    );
  }
}
