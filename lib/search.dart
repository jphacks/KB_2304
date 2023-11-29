// import 'dart:js_interop';
// import 'dart:js_util';

import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'dart:convert';

// import 'dart:developer';
import 'package:dson_adapter/dson_adapter.dart';

// import 'package:hallo_world/distance_checker.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySearchPage(title: 'Search Page'),
    );
  }
}

class MySearchPage extends StatefulWidget {
  final String title;

  const MySearchPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// class Station {
//   final int Column2;
//   final String Column3;
//   final int Column6;
//   final int Column7;
//   final String Column8;
//   final String Column9;
//   final double Column10;
//   final double Column11;
//   final String Column12;
//   final String Column13;
//   final int Column14;
//   final int Column15;

//   Station({
//     required this.Column2,
//     required this.Column3,
//     required this.Column6,
//     required this.Column7,
//     required this.Column8,
//     required this.Column9,
//     required this.Column10,
//     required this.Column11,
//     required this.Column12,
//     required this.Column13,
//     required this.Column14,
//     required this.Column15,
//   });
// }

class Station {
  final int station_cd;
  final int station_g_cd;
  final String station_name;
  final String station_name_k;
  final String station_name_r;
  final int line_cd;
  final int pref_cd;
  final String post;
  final String address;
  final double lon;
  final double lat;
  final String open_ymd;
  final String close_ymd;
  final int e_status;
  final int e_sort;

  Station({
    required this.station_cd,
    required this.station_g_cd,
    required this.station_name,
    required this.station_name_k,
    required this.station_name_r,
    required this.line_cd,
    required this.pref_cd,
    required this.post,
    required this.address,
    required this.lon,
    required this.lat,
    required this.open_ymd,
    required this.close_ymd,
    required this.e_status,
    required this.e_sort,
  });
}

class _MyHomePageState extends State<MySearchPage> {
  String _data = "Load JSON Data";
  String data = "";
  final jsonArray = "";
  int tes = 0;
  int a = 0;
  List<String> _list = <String>[];
  List<Station> stations = <Station>[];
  String lis = "";
  Station? station;

  void _updateJsonData() {
    // jsonファイル読み込み用
    if (tes == 0) {
      getLocalTestJSONData();
      tes++;
    }
  }

  /*
   * ローカルJSONファイル読み込みテスト用'json/kobestation_test.json'
   */
  Future<String> _loadAVaultAsset() async {
    return await rootBundle.loadString('json/station.json');
  }

  /*
   * ローカルJSON　データセット
   */
  Future getLocalTestJSONData() async {
    String jsonString = await _loadAVaultAsset();
    var jsonResponse = jsonDecode(jsonString) as List<dynamic>;

    for (int i = 0; i < jsonResponse.length; i++) {
      const dson = DSON();
      stations.add(dson.fromJson(jsonResponse[i], Station.new));
    }

    if (a == 0) {
      for (int i = 0; i < stations.length; i++) {
        // _list.add(stations[i].Column3);
        _list.add(stations[i].station_name);

        a++;
      }
    }

    setState(() {
      _list;
    });
  }

  bool _searchBoolean = false;
  List<int> _searchIndexList = [];

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < _list.length; i++) {
            if (_list[i].contains(s)) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true, //TextFieldが表示されるときにフォーカスする（キーボードを表示する）
      cursorColor: Colors.white, //カーソルの色
      style: TextStyle(
        //テキストのスタイル
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search, //キーボードのアクションボタンを指定
      decoration: InputDecoration(
        //TextFiledのスタイル
        enabledBorder: UnderlineInputBorder(
            //デフォルトのTextFieldの枠線
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //TextFieldにフォーカス時の枠線
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search', //何も入力してないときに表示されるテキスト
        hintStyle: TextStyle(
          //hintTextのスタイル
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length, //編集
        itemBuilder: (context, index) {
          index = _searchIndexList[index]; //追加
          return Card(child: ListTile(title: Text(_list[index])));
        });
  }

  Widget _defaultListView() {
    int a = 0;
    if (a == 0) {
      _updateJsonData();
      a++;
    }
    return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return Card(child: ListTile(title: Text(_list[index])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: !_searchBoolean ? Text(widget.title) : _searchTextField(),
            actions: !_searchBoolean
                ? [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          _updateJsonData();
                          setState(() {
                            _searchBoolean = true;
                            _searchIndexList = [];
                          });
                        })
                  ]
                : [
                    IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchBoolean = false;
                          });
                        })
                  ]),
        // body: !_searchBoolean ? _defaultListView() : _searchListView());
        body: !_searchBoolean ? _defaultListView() : _searchListView());
    // body: _updateJsonData();
  }
}
