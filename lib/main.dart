import 'package:edu_application_pre/common/kiosk_main.dart';
import 'package:edu_application_pre/layout/splash_screen.dart';
import 'package:edu_application_pre/user/class.dart';
import 'package:edu_application_pre/user/enter_suggestion.dart';
import 'package:edu_application_pre/user/myprofile_page.dart';
import 'package:edu_application_pre/user/qr.dart';
import 'package:edu_application_pre/user/suggestions.dart';
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
        '/': (context) => SplashScreen(),
        '/kiosk': (context) => KioskMain(),
        '/home': (context) => MyHomePage(),
        '/profile': (context) => MyProfilePage(),
        '/qr': (context) => QrCheck(),
        '/suggestion': (context) => Suggestions(),
        '/enter-suggestion': (context) => EnterSuggestion(),
        '/class': (context) => Class(),
      },
      debugShowCheckedModeBanner: false,
      title: 'first app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff0099FF)),
        textTheme: const TextTheme(
            bodyMedium: TextStyle(
          //전체 바디 폰트 스타일 미디움?? 이건 뭔지 모르겠음 일단 전체 적용됨.
          fontSize: 16,
          color: Color(0xff9c9c9c),
          fontWeight: FontWeight.w600,
        )),
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
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, //정렬, spaceAround: 간격의 절반 양끝 여백, spaceBetween: 여백x, spaceEvenly: 간격 만큼 여백
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/class');
                    },
                    icon: FaIcon(FontAwesomeIcons.clipboardCheck),
                    color: Color(0xff9c9c9c),
                    iconSize: 55,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.userPen),
                    color: Color(0xff9c9c9c),
                    iconSize: 55,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.book),
                    color: Color(0xff9c9c9c),
                    iconSize: 55,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/qr');
                    },
                    icon: FaIcon(FontAwesomeIcons.qrcode),
                    color: Color(0xff9c9c9c),
                    iconSize: 55,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/suggestion');
                    },
                    icon: FaIcon(FontAwesomeIcons.envelopeOpen),
                    color: Color(0xff9c9c9c),
                    iconSize: 55,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.gear),
                    color: Color(0xff9c9c9c),
                    iconSize: 55,
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
