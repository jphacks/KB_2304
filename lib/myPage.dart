import 'dart:ffi';

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

class _HomeState extends State<Home> {
  int checkerDistance = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyPage"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                  child: TextField(
                      onChanged: (text) {
                        setState(() {
                          if (int.parse(text) >= 0 &&
                              int.parse(text) <= 25000) {
                            checkerDistance = 100;
                          } else {
                            checkerDistance = int.parse(text);
                          }
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '100m~20000m',
                        labelText: 'distance(m)',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
