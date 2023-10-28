import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key, required this.title});
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

// --------- 切り替える画面 -----------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('ホーム'));
  }
}

class SearchPage extends StatelessWidget {
  List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];

  Widget _defaultListView() {
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
          title: Text("検索"),
        ),
        body: _defaultListView());
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('地図')),
      color: Colors.green[200],
    );
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
