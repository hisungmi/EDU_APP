import 'dart:convert';

import 'package:edu_application_pre/common/kiosk_main.dart';
import 'package:edu_application_pre/common/main_page.dart';
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
        '/mainpage': (context) => MainPage(),
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool?> confirmation(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('로그아웃'),
              content: Text('로그아웃 하시겠습니까?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('확인')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('취소')),
              ]);
        });
  }

  Future<void> logOut(BuildContext context) async {
    bool? confirmed = await confirmation(context);
    if (confirmed == true) {
      //로컬 스토리지 지우기
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');

      Navigator.pushNamedAndRemoveUntil(context, "/mainpage", (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    PageController pagecontroller = PageController(initialPage: _currentIndex);
    final List<Widget> pages = [
      Schedule(),
      Class(
        pageIndex: 'attendance',
      ),
      Class(
        pageIndex: 'exam',
      ),
      Class(
        pageIndex: 'assignment',
      ),
      Notice()
    ];

    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/img/logo.png',
            height: 50,
          ),
          centerTitle: true, // 텍스트 중앙 정렬
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.qrcode),
            color: Color(0xff0099ff),
            iconSize: 35,
            onPressed: () {
              Navigator.pushNamed(context, '/qr');
            },
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE8E8E8).withOpacity(0.8),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          toolbarHeight: 80,
          elevation: 4.0, //앱바 입체감 없애기
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              color: Color(0xff0099ff),
              iconSize: 35,
              onPressed: () {
                fullMenu();
              },
            )
          ],
        ),
        endDrawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text('menu')),
            ListTile(
              title: Text('item'),
              onTap: () {},
            )
          ],
        )),
        body: PageView(
          controller: pagecontroller,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: pages,
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xffA9A9A9), // 원하는 색상 설정
                width: 1.0, // 경계선의 두께 설정
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: Color(0xff0099ff),
            unselectedItemColor: Color(0xff9c9c9c),
            selectedLabelStyle: TextStyle(
              color: Color(0xff0099ff),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              color: Color(0xff9c9c9c),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                pagecontroller.jumpToPage(index);
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.chartPie,
                  ),
                  label: '시간표'),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.clipboardCheck,
                  ),
                  label: '출결현황'),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.userPen,
                  ),
                  label: '시험'),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.book,
                  ),
                  label: '과제'),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.bullhorn,
                  ),
                  label: '공지사항')
            ],
          ),
        ));
  }

  Future fullMenu() {
    return showModalBottomSheet(
        //밑에서 열리는 메뉴
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.white,
              child: Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.min, //크기만큼만 차지
                      children: [
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.circleUser),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('프로필',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);

                            Navigator.pushNamedAndRemoveUntil(
                                context, "/profile", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // SizedBox(
                    //   height: 52,
                    //   child: Card(
                    //     elevation: 0,
                    //     child: ListTile(
                    //       leading: FaIcon(FontAwesomeIcons.chartPie),
                    //       iconColor: Color(0xff9c9c9c),
                    //       title: Text('시간표',
                    //           style: TextStyle(
                    //             color: Color(0xff9c9c9c),
                    //             fontWeight: FontWeight.bold,
                    //           )),
                    //       subtitle: Divider(thickness: 1),
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //         Navigator.pushNamedAndRemoveUntil(
                    //             context, "/schedule", (route) => false);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ), //시간표
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.qrcode),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('출석 QR',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/qr", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // SizedBox(
                    //   //카드형식 높이주기위해 감쌈
                    //   height: 52,
                    //   child: Card(
                    //     //카드형식
                    //     elevation: 0,
                    //     child: ListTile(
                    //       leading: FaIcon(FontAwesomeIcons.clipboardCheck),
                    //       iconColor: Color(0xff9c9c9c),
                    //       title: Text('출석 현황',
                    //           style: TextStyle(
                    //             color: Color(0xff9c9c9c),
                    //             fontWeight: FontWeight.bold,
                    //           )),
                    //       subtitle: Divider(thickness: 1),
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //         Navigator.pushNamedAndRemoveUntil(
                    //             context, "/class", (route) => false);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ), //출석현황
                    // SizedBox(
                    //   //카드형식 높이주기위해 감쌈
                    //   height: 52,
                    //   child: Card(
                    //     //카드형식
                    //     elevation: 0,
                    //     child: ListTile(
                    //       leading: FaIcon(FontAwesomeIcons.userPen),
                    //       iconColor: Color(0xff9c9c9c),
                    //       title: Text('시험',
                    //           style: TextStyle(
                    //             color: Color(0xff9c9c9c),
                    //             fontWeight: FontWeight.bold,
                    //           )),
                    //       subtitle: Divider(thickness: 1),
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //         Navigator.pushNamedAndRemoveUntil(
                    //             context, "/exam", (route) => false);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),//시험
                    // SizedBox(
                    //   //카드형식 높이주기위해 감쌈
                    //   height: 52,
                    //   child: Card(
                    //     //카드형식
                    //     elevation: 0,
                    //     child: ListTile(
                    //       leading: FaIcon(FontAwesomeIcons.book),
                    //       iconColor: Color(0xff9c9c9c),
                    //       title: Text('과제',
                    //           style: TextStyle(
                    //             color: Color(0xff9c9c9c),
                    //             fontWeight: FontWeight.bold,
                    //           )),
                    //       subtitle: Divider(thickness: 1),
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //         Navigator.pushNamedAndRemoveUntil(
                    //             context, "/assigment", (route) => false);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),//과제
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.envelopeOpen),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('건의사항',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/suggestion", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // SizedBox(
                    //   //카드형식 높이주기위해 감쌈
                    //   height: 52,
                    //   child: Card(
                    //     //카드형식
                    //     elevation: 0,
                    //     child: ListTile(
                    //       leading: FaIcon(FontAwesomeIcons.bullhorn),
                    //       iconColor: Color(0xff9c9c9c),
                    //       title: Text('공지사항',
                    //           style: TextStyle(
                    //             color: Color(0xff9c9c9c),
                    //             fontWeight: FontWeight.bold,
                    //           )),
                    //       subtitle: Divider(thickness: 1),
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ), //공지사항
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.signOut),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('로그아웃',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            logOut(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ])));
        });
  }
}
