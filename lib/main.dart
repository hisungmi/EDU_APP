import 'dart:convert';

import 'package:edu_application_pre/common/kiosk_main.dart';
import 'package:edu_application_pre/layout/splash_screen.dart';
import 'package:edu_application_pre/notice.dart';
import 'package:edu_application_pre/qr_scanner.dart';
import 'package:edu_application_pre/user/class.dart';
import 'package:edu_application_pre/user/enter_suggestion.dart';
import 'package:edu_application_pre/user/myprofile_page.dart';
import 'package:edu_application_pre/user/qr.dart';
import 'package:edu_application_pre/schedule.dart';
import 'package:edu_application_pre/user/suggestions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //MyHomePage 위젯에서 DateFormat 클래스를 사용하여 날짜와 시간을 표시할 때 한국어 로케일을 사용
  await initializeDateFormatting('ko_KR');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => QrProvider()),
  ], child: MyApp()));
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
        // '/test': (context) => QrScanner(),
        '/schedule': (context) => Schedule(),
        '/notice': (context) => Notice(),
      },
      debugShowCheckedModeBanner: false,
      title: 'first app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff0099FF)),
        textTheme: const TextTheme(
            headlineMedium:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';
  void loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      Map<dynamic, dynamic> dataMap = jsonDecode(userData);

      setState(() {
        name = dataMap['name'] ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd.EEE', 'ko_KR').format(now);
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
            iconSize: 40,
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 23.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 385,
                child: Text(formattedDate,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              Container(
                  width: 390,
                  child: Text('$name 님의 시간표',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xff595959),
                          fontSize: 18,
                          fontWeight: FontWeight.w500))),
              SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/schedule');
                },
                child: Container(
                    width: 394,
                    height: 330,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Color(0xff9c9c9c),
                      width: 1,
                    )),
                    child: SingleChildScrollView(
                      child: TimeTable(
                        isAfternoon: true,
                        toggleAfternoon: () {},
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, //정렬, spaceAround: 간격의 절반 양끝 여백, spaceBetween: 여백x, spaceEvenly: 간격 만큼 여백
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Class(pageIndex: 'attendance')),
                          );
                        },
                        icon: FaIcon(FontAwesomeIcons.clipboardCheck),
                        color: Color(0xff9c9c9c),
                        iconSize: 55,
                      ),
                      Text('출결현황',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Class(pageIndex: 'exam')),
                          );
                        },
                        icon: FaIcon(FontAwesomeIcons.userPen),
                        color: Color(0xff9c9c9c),
                        iconSize: 55,
                      ),
                      Text('시험',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Class(pageIndex: 'assignment')),
                          );
                        },
                        icon: FaIcon(FontAwesomeIcons.book),
                        color: Color(0xff9c9c9c),
                        iconSize: 55,
                      ),
                      Text('과제',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/qr');
                        },
                        icon: FaIcon(FontAwesomeIcons.qrcode),
                        color: Color(0xff9c9c9c),
                        iconSize: 55,
                      ),
                      Text('QR',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/suggestion');
                        },
                        icon: FaIcon(FontAwesomeIcons.envelopeOpen),
                        color: Color(0xff9c9c9c),
                        iconSize: 55,
                      ),
                      Text('건의사항',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/notice');
                        },
                        icon: FaIcon(FontAwesomeIcons.bullhorn),
                        color: Color(0xff9c9c9c),
                        iconSize: 55,
                      ),
                      Text('공지사항',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600))
                    ],
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
