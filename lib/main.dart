import 'package:edu_application_pre/common/main_page.dart';
import 'package:edu_application_pre/user/myprofile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        '/profile': (context) => MyProfilePage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'first app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff0099FF)),
        textTheme: const TextTheme(),
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
        title: InkWell(
          //기본적인 클릭이벤트들이 내장되어있음, 애니메이션도 기본 없애려면 Colors.transparent 정의,
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
          child: Image.asset(
            "assets/img/whitelogo.png",
            height: 80,
          ),
        ),
        automaticallyImplyLeading: false, //기본 왼ㅉ고 토굴 안생기게
        backgroundColor: Color(0xff0099FF),
        toolbarHeight: 80,
        elevation: 0.0, //앱바 입체감 없애기

        actions: [
          IconButton(
            icon: Icon(Icons.perm_identity),
            iconSize: 30,
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.clipboardCheck),
                    color: Color(0xff9c9c9c),
                    iconSize: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.userPen),
                    color: Color(0xff9c9c9c),
                    iconSize: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.book),
                    color: Color(0xff9c9c9c),
                    iconSize: 50,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.qrcode),
                    color: Color(0xff9c9c9c),
                    iconSize: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.envelopeOpen),
                    color: Color(0xff9c9c9c),
                    iconSize: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.gear),
                    color: Color(0xff9c9c9c),
                    iconSize: 50,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
