// import 'dart:ffi';

import 'notification.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

var sound = true;
var checkerDistance = 100;

class Setting {
  // sound;

  static getSound() {
    return sound;
  }

  static getCheckerDistance() {
    return checkerDistance;
  }
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyPage"),
      ),
      body: Center(
        child: GestureDetector(
          // onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                    onChanged: (text) {
                      setState(() {
                        if (int.parse(text) >= 0 && int.parse(text) <= 25000) {
                          checkerDistance = 100;
                        } else {
                          checkerDistance = int.parse(text);
                        }
                      });
                    },
                    decoration: InputDecoration(
                      // hintText: String(checkerDistance),
                      labelText: 'distance(m)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                Column(
                  children: <Widget>[
                    new SwitchListTile(
                        value: sound,
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey,
                        title: Text('通知の音'),
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              sound = value;
                              print("$sound");
                            });
                          }
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
