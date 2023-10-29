import 'dart:js_interop';
import 'dart:js_util';

import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'dart:developer';
import 'package:dson_adapter/dson_adapter.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySearchPage(title: 'Flutter Demo Home Page'),
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

class Station {
  // final int 表1;
  final int Column2;
  final String Column3;
  final int Column6;
  final int Column7;
  final String Column8;
  final String Column9;
  final double Column10;
  final double Column11;
  final String Column12;
  final String Column13;
  final int Column14;
  final int Column15;

  Station({
    required this.Column2,
    required this.Column3,
    required this.Column6,
    required this.Column7,
    required this.Column8,
    required this.Column9,
    required this.Column10,
    required this.Column11,
    required this.Column12,
    required this.Column13,
    required this.Column14,
    required this.Column15,
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
    // 直打ち用
    final data = [
      {
        "Column2": 1160313,
        "Column3": "神戸三宮",
        "Column6": 34001,
        "Column7": 28,
        "Column8": "650-0001",
        "Column9": "神戸市中央区加納町４-２-１",
        "Column10": 135.192862,
        "Column11": 34.693136,
        "Column12": "0000-00-00",
        "Column13": "0000-00-00",
        "Column14": 0,
        "Column15": 3400116
      },
      {
        "Column2": 3400115,
        "Column3": "春日野道",
        "Column6": 34001,
        "Column7": 28,
        "Column8": "651-0076",
        "Column9": "神戸市中央区吾妻通一丁目",
        "Column10": 135.205396,
        "Column11": 34.70299,
        "Column12": "0000-00-00",
        "Column13": "0000-00-00",
        "Column14": 0,
        "Column15": 3400115
      },
    ];

    for (int i = 0; i < data.length; i++) {
      const dson = DSON();
      stations.add(dson.fromJson(data[i], Station.new));
    }

    if (a == 0) {
      for (int i = 0; i < stations.length; i++) {
        _list.add(stations[i].Column3);
        a++;
      }
    }

    setState(() {
      _list;
    });

    //実験中
    // if (tes == 0) {
    //   getLocalTestJSONData();
    //   tes++;
    // }
  }

  // Future<void> loadAsset() async {}

  /*
   * ローカルJSONファイル読み込みテスト用「api_name.json」
   */
  Future<String> _loadAVaultAsset() async {
    return await rootBundle.loadString('json/kobestation_test.json');
  }

  int b = 0;
  /*
   * ローカルJSON　データセット
   */
  Future getLocalTestJSONData() async {
    // String jsonString = await _loadAVaultAsset();
    // final jsonResponse = json.decode(jsonString);
    // log("dmksfms");
    // station = jsonResponse;

    // b++;

    // String jsonString = await _loadAVaultAsset();
    // final jsonResponse = json.decode(jsonString);
    // log("dmksfms");

    // for (int i = 0; i < jsonResponse.length; i++) {
    //   const dson = DSON();
    //   stations.add(dson.fromJson(jsonString[i], Dynamic.new));
    // }

    // if (a == 0) {
    //   for (int i = 0; i < stations.length; i++) {
    //     _list.add(stations[i].Column3);
    //     a++;
    //   }
    // }

    setState(() {
      _list;
    });
  }

  bool _searchBoolean = false;
  List<int> _searchIndexList = [];

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        //追加
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
