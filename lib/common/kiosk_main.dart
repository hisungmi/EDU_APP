import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:edu_application_pre/http_setup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrProvider extends ChangeNotifier {
  bool _isQr = false;
  bool get isQr => _isQr;

  void setFalseQr() {
    _isQr = false;
    notifyListeners();
  }

  void setTrueQr() {
    _isQr = true;
    notifyListeners();
  }

  void toggleQr() {
    _isQr = !_isQr;
    notifyListeners();
  }
}

final GlobalKey<KioskMainState> kioskMainKey = GlobalKey<KioskMainState>();

class KioskMain extends StatefulWidget {
  KioskMain({Key? key}) : super(key: kioskMainKey);

  @override
  State<KioskMain> createState() => KioskMainState();
}

class KioskMainState extends State<KioskMain> {
  Map<String, dynamic> qrData = {'qrKey': 'kiosk'};

  void refresh() {
    setState(() {});
  }

  final List<String> backgroundImages = [
    '../assets/img/background01.jpg',
    '../assets/img/background02.jpg',
  ];
  static Map<String, dynamic> todayNotice = {};
  String newNotice = '';
  static List<dynamic> lectureList = [];

  Future getNotice() async {
    Map<String, String> data = {
      'userKey': '',
      'search': '',
      'date': DateTime.now().year.toString(),
      'type': '',
    };

    var result = await post('/info/getNoticeList/', jsonEncode(data));
    if (result.statusCode == 200) {
      setState(() {
        if (result.data['resultData'].length > 0) {
          if (int.parse(DateTime.now()
                  .difference(DateTime.parse(result.data['resultData'][0]
                          ['createDate']
                      .toString()
                      .split('T')[0]
                      .replaceAll('-', '')))
                  .inDays
                  .toString()) <
              7) {
            newNotice = result.data['resultData'][0]['title'];
          }
        }
      });
    }
  }

  Future getLectureList() async {
    Map<String, dynamic> data = {
      'userKey': '',
      'roomKey': '',
      'roomName': '',
      'lectureName': '',
      'target': '',
    };

    var result = await post('/lectures/getLectureList/', jsonEncode(data));
    if (result.statusCode == 200) {
      List<Map<String, dynamic>> filteredLectures =
          List<Map<String, dynamic>>.from(result.data['resultData'])
              .where((lecture) => lecture['progress'] == '등록')
              .toList();
      setState(() {
        lectureList = filteredLectures;
      });
    }
  }

  @override
  void initState() {
    getLectureList();
    getNotice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return Consumer<QrProvider>(builder: (context, qrProvider, child) {
      return Scaffold(
          body: GestureDetector(
        onTap: () {
          Provider.of<QrProvider>(context, listen: false).toggleQr();
        },
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(backgroundImages[
                        random.nextInt(backgroundImages.length)]))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!qrProvider.isQr)
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(50, 50, 0, 50),
                          child: Container(
                              width: 400.0,
                              height: 260.0,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20.0),
                                          child: Image.asset(
                                            '../assets/img/iconsample01.png',
                                            width: 96.0,
                                          ),
                                        ),
                                        Text(
                                          "현재 통합 대기",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.6),
                                          ),
                                        ),
                                        Text(
                                          '나쁨',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "실내 대기",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.6),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 10.0, 0, 20.0),
                                        child: Text(
                                          '보통',
                                          style: TextStyle(
                                              fontSize: 44.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: "미세 먼지 ",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "보통(35)",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ]),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: "초미세 먼지 ",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "나쁨(68)",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ]),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 43.0, 0, 15.0),
                                  width: 1220.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 60.0),
                                        child: Icon(
                                          newNotice.isEmpty
                                              ? FontAwesomeIcons.solidBellSlash
                                              : FontAwesomeIcons.solidBell,
                                          size: 55,
                                          color: Color(0xffFFFFFF),
                                        ),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: newNotice.isEmpty
                                                  ? Text('최신 공지가 없습니다',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff565656),
                                                        fontSize: 36.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))
                                                  : Text(newNotice,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 36.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )))),
                                    ],
                                  ),
                                ),
                                Text("QR 인증을 하시려면 스크린을 터치해주세요.",
                                    style: TextStyle(
                                      color: Color(0xff565656),
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.normal,
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        height: 580.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: lectureList.length,
                          itemBuilder: (context, index) {
                            TextStyle myTextStyle = TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                            );

                            String room = lectureList[index]['roomName'];
                            String name = lectureList[index]['lectureName'];
                            String startTime = lectureList[index]['startTime']
                                .toString()
                                .replaceAll('-', ':');
                            if (startTime.length < 3) {
                              startTime = '$startTime:00';
                            }
                            String teacher = lectureList[index]['teacherName'];

                            return Stack(children: [
                              Container(
                                  width: 380,
                                  height: 550,
                                  margin:
                                      EdgeInsets.fromLTRB(30.00, 0, 30.0, 0),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff000000).withOpacity(0.1),
                                        blurRadius: 30,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(room,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: myTextStyle.copyWith(
                                                fontSize: 60.0)),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 30, 0, 30),
                                          width: 100,
                                          height: 1, //// 선의 높이를 지정합니다
                                          color: Colors.white, // 선의 색상을 지정합니다
                                        ),
                                        Text(name,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: myTextStyle.copyWith(
                                                fontSize: 48.0)),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 20, 0, 20),
                                          child: Text('$startTime 에 시작',
                                              style: myTextStyle.copyWith(
                                                  fontSize: 28.0,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                        Text.rich(
                                          textAlign: TextAlign.center,
                                          TextSpan(
                                            text: teacher,
                                            style: myTextStyle,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ' 강사님',
                                                style: myTextStyle.copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 30.0),
                                          child: Text.rich(
                                            textAlign: TextAlign.center,
                                            TextSpan(
                                              text: '출석 ',
                                              style: myTextStyle,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '10',
                                                  style: myTextStyle.copyWith(
                                                      fontSize: 36.0),
                                                ),
                                                TextSpan(
                                                  text: ' / 전체 24 인',
                                                  style: myTextStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ]);
                            // child: Text(
                            //   name,
                            // ));
                          },
                        )),
                  ]),
                if (qrProvider.isQr)
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(backgroundImages[
                                    random.nextInt(backgroundImages.length)]))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 43.0, 0, 15.0),
                            width: 770.0,
                            height: 790.0,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 130.0),
                                    child: QrImageView(
                                      data:
                                          'https://banbbom.com/data/froala/210318/619072b81882e82473c9fc84436edf7f4ae65ef9.jpg',
                                      backgroundColor: Color(0xff000000),
                                      size: 450,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 72.0),
                                    child: MyTimer(),
                                  ),
                                  Text('메인으로 돌아가려면 화면을 터치해 주세요.',
                                      style: TextStyle(
                                        color: Color(0xff565656),
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.normal,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(
                  width: 170.0,
                  child: Image.asset(
                    'assets/img/whitelogo.png',
                  ),
                ),
              ],
            )),
      ));
    });
  }
}

class MyTimer extends StatefulWidget {
  const MyTimer({Key? key}) : super(key: key);

  @override
  State<MyTimer> createState() => MyTimerState();
}

class MyTimerState extends State<MyTimer> {
  static const int _maxSeconds = 20;
  int _secondsLeft = _maxSeconds;

  late Timer _timer;

  String _formatSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 1) {
          _secondsLeft--;
        } else {
          _timer.cancel();
          Provider.of<QrProvider>(context, listen: false).setFalseQr();
          kioskMainKey.currentState!.refresh();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_formatSeconds(_secondsLeft),
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
          )),
    );
  }
}
