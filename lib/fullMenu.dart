import 'dart:convert';

import 'package:edu_application_pre/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

String name = '';
String userType = '';

Future<void> loadData() async {
  // 로컬 스토리지에서 데이터 불러오기
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userData = prefs.getString('userData');
  String? typeData = prefs.getString('userType');

  if (userData != null && typeData != null) {
    Map<dynamic, dynamic> dataMap = jsonDecode(userData);
    Map<dynamic, dynamic> typeMap = jsonDecode(typeData);

    name = dataMap['name'] ?? '';
    userType = typeMap['userType'] ?? '';
  }
}

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
    prefs.remove('PARData');
    prefs.remove('typeData');

    Navigator.pushNamedAndRemoveUntil(context, "/mainpage", (route) => false);
  }
}

Future<dynamic> fullMenu(BuildContext context) {
  loadData();
  return showModalBottomSheet(
      //밑에서 열리는 메뉴
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return Container(
            height: userType == 'STU'
                ? MediaQuery.of(context).size.height * 0.7
                : MediaQuery.of(context).size.height * 0.6,
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
                          Navigator.pushNamed(context, "/profile").then((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(0),
                                ));
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 52,
                    child: Card(
                      elevation: 0,
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.chartPie),
                        iconColor: Color(0xff9c9c9c),
                        title: Text('시간표',
                            style: TextStyle(
                              color: Color(0xff9c9c9c),
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Divider(thickness: 1),
                        onTap: () {
                          int desiredIndex = 0; // 2번째 인덱스로 이동하려면 1로 설정
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(desiredIndex),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (userType == 'STU')
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.qrcode),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('QR Scanner',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pushNamed(context, "/qrscanner")
                                .then((_) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(0),
                                  ));
                            });
                          },
                        ),
                      ),
                    ),
                  if (userType == 'STU')
                    SizedBox(
                      height: 5,
                    ),
                  SizedBox(
                    //카드형식 높이주기위해 감쌈
                    height: 52,
                    child: Card(
                      //카드형식
                      elevation: 0,
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.clipboardCheck),
                        iconColor: Color(0xff9c9c9c),
                        title: Text('출석 현황',
                            style: TextStyle(
                              color: Color(0xff9c9c9c),
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Divider(thickness: 1),
                        onTap: () {
                          int desiredIndex = 1; // 2번째 인덱스로 이동하려면 1로 설정
                          //MatrialpageRoute 를 사용하여 스택지우고 이동할 경우 pushAndRemoveUntil / 미리 정의된 라우트이름을 사용하는거면 pushNameAndRemoveUntil
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(desiredIndex),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    //카드형식 높이주기위해 감쌈
                    height: 52,
                    child: Card(
                      //카드형식
                      elevation: 0,
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.userPen),
                        iconColor: Color(0xff9c9c9c),
                        title: Text('시험',
                            style: TextStyle(
                              color: Color(0xff9c9c9c),
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Divider(thickness: 1),
                        onTap: () {
                          int desiredIndex = 2;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(desiredIndex),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    //카드형식 높이주기위해 감쌈
                    height: 52,
                    child: Card(
                      //카드형식
                      elevation: 0,
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.book),
                        iconColor: Color(0xff9c9c9c),
                        title: Text('과제',
                            style: TextStyle(
                              color: Color(0xff9c9c9c),
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Divider(thickness: 1),
                        onTap: () {
                          int desiredIndex = 3;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(desiredIndex),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
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
                          Navigator.pushNamed(context, "/suggestion").then((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(0),
                                ));
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    //카드형식 높이주기위해 감쌈
                    height: 52,
                    child: Card(
                      //카드형식
                      elevation: 0,
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.bullhorn),
                        iconColor: Color(0xff9c9c9c),
                        title: Text('공지사항',
                            style: TextStyle(
                              color: Color(0xff9c9c9c),
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Divider(thickness: 1),
                        onTap: () {
                          int desiredIndex = 4;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(desiredIndex),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
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
