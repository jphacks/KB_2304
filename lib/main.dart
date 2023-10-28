import 'package:flutter/material.dart';
import 'package:hallo_world/homePage.dart';
import 'package:hallo_world/map.dart';
import 'package:hallo_world/search.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 選択中フッターメニューのインデックスを一時保存する用変数
  int selectedIndex = 0;

  // 切り替える画面のリスト
  List<Widget> display = [HomePage(), SearchPage(), MapPage(), MyPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: setNotification,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        // appBar: AppBar(title: Text('BottomNavigationBar')),
        body: display[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: '地図'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'マイページ'),
          ],
          // 現在選択されているフッターメニューのインデックス
          currentIndex: selectedIndex,
          // フッター領域の影
          elevation: 0,
          // フッターメニュータップ時の処理
          onTap: (int index) {
            selectedIndex = index;
            setState(() {});
          },
          // 選択中フッターメニューの色
          fixedColor: Colors.red,
          unselectedItemColor: Color.fromARGB(255, 87, 86, 86),
          backgroundColor: Color.fromARGB(255, 82, 88, 89),
        ));
  }
}
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('マイページ')),
      color: const Color.fromARGB(255, 165, 208, 214),
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  runApp(const MyApp());
}

void setNotification() async {
  const DarwinNotificationDetails iOSPlatformChannelSpecifics =
      DarwinNotificationDetails(
          // sound: 'example.mp3',
          presentAlert: true,
          presentBadge: true,
          presentSound: true);
  NotificationDetails platformChannelSpecifics =
      const NotificationDetails(iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'title', 'body', platformChannelSpecifics);
}
