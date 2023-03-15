import 'package:edu_application_pre/common/main_page.dart';
import 'package:edu_application_pre/user/myprofile_page.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/home': (context) => MyHomePage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'first app',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff0099FF)),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xff9C9C9C),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/img/whitelogo.png",
          height: 80,
        ),
        centerTitle: true,
        backgroundColor: Color(0xff0099FF),
        toolbarHeight: 80,
        elevation: 0.0, //앱바 입체감 없애기
        // leading: IconButton(
        //     icon: Icon(Icons.menu),
        //     iconSize: 30,
        //     onPressed: () {
        //       print("클릭");
        //     }
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.perm_identity),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProfilePage()),
              );
            },
          )
        ],
      ),
      drawer: Drawer(),
    );
  }
}
