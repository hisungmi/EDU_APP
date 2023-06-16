import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/kiosk_main.dart';
import '../http_setup.dart';
import '../qr_code_scanner.dart';

class ClassMain extends StatefulWidget {
  const ClassMain({Key? key}) : super(key: key);

  @override
  State<ClassMain> createState() => ClassMainState();
}

class ClassMainState extends State<ClassMain> {
  Map<String, dynamic> qrData = {'qrKey': 'kiosk'};
  static String roomKey = '';
  static List<dynamic> lectureList = [];
  static List<dynamic> todayLectures = [];
  static Map<String, dynamic> lectureDetail = {};
  static List<dynamic> lectureStatsList = [];
  static List<dynamic> attendList = [];

  Future setRoomData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roomData = prefs.getString('roomData');

    roomKey = jsonDecode(roomData!)['roomKey'];
  }

  Future<void> getAttendList() async {
    Map<String, dynamic> data = {
      'userKey': '',
      'lectureKey': lectureDetail['lectureKey'],
    };

    var result = await post('/info/getAttendList/', jsonEncode(data));

    if (result.statusCode == 200) {
      setState(() {
        attendList = result.data['resultData'];
      });
    }
  }

  Future<void> getLectureStatus() async {
    final qrAttendListProvider = Provider.of<AttendProvider>(context);
    await getAttendList();

    if (attendList.isNotEmpty) {
      lectureStatsList = attendList;
      print(lectureStatsList);
    } else {
      Map<String, dynamic> data = {
        'userKey': '',
        'search': '',
        'lectureKey': lectureDetail['lectureKey'],
      };

      var result = await post('/members/getStudentList/', jsonEncode(data));

      if (result.statusCode == 200) {
        setState(() {
          lectureStatsList = result.data['resultData'];
        });

        print(qrAttendListProvider.qrAttendList);

        for (int i = 0; i < lectureStatsList.length; i++) {
          lectureStatsList[i]['studentName'] = lectureStatsList[i]['name'];
          lectureStatsList[i]['state'] = '';

          print(qrAttendListProvider.qrAttendList);

          for (int k = 0; k < qrAttendListProvider.qrAttendList.length; k++) {
            if (lectureStatsList[i]['studentKey'] ==
                qrAttendListProvider.qrAttendList[k]['studentKey']) {
              lectureStatsList[i]['state'] =
                  qrAttendListProvider.qrAttendList[k]['state'];
            }
          }
        }
      }
    }
  }

  Future<void> getLectureList() async {
    await setRoomData();

    Map<String, dynamic> data = {
      'userKey': '',
      'roomKey': roomKey,
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

    DateTime now = DateTime.now();
    int todayWeekday = now.weekday;

    todayLectures = lectureList.where((lecture) {
      int lectureWeekday = lecture['day'];

      if (lectureWeekday != todayWeekday) {
        return false;
      }

      int lectureStartHour = int.parse(lecture['startTime'].substring(0, 2));
      int lectureStartMinute = int.parse(lecture['startTime'].substring(3, 5));
      int lectureDuration = lecture['duration'];

      DateTime lectureStartTime = DateTime(
          now.year, now.month, now.day, lectureStartHour, lectureStartMinute);
      DateTime lectureEndTime =
          lectureStartTime.add(Duration(minutes: lectureDuration));

      return now.isAfter(lectureStartTime) && now.isBefore(lectureEndTime);
    }).toList();

    lectureDetail = todayLectures[0];
    if (lectureDetail.isNotEmpty) {
      await getLectureStatus();
    }
  }

  Future<void> createAttend() async {
    List<dynamic> data = [];

    for (int j = 0; j < lectureStatsList.length; j++) {
      data.add({
        'studentName': lectureStatsList[j]['name'],
        'studentKey': lectureStatsList[j]['studentKey'],
        'lectureName': lectureDetail['lectureName'],
        'lectureKey': lectureDetail['lectureKey'],
        'state': lectureStatsList[j]['state'],
      });
    }

    var result = await post('/info/createAttend/', jsonEncode(data));

    if (result.data['chunbae'] == '데이터 생성.') {
      setState(() {
        attendList = result.data['resultData'];
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('성공'),
            content: Text('출석 현황을 성공적으로 저장했습니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("확인"),
              ),
            ],
          );
        },
      );

      setState(() {});
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
      prefs.remove('roomData');

      Navigator.pushNamedAndRemoveUntil(context, "/mainpage", (route) => false);
    }
  }

  @override
  void initState() {
    getLectureList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendProvider>(builder: (context, attendProvider, child) {
      return Scaffold(
          body: Stack(
        children: [
          Positioned(
            top: 30.0,
            right: 10.0,
            width: 100.0,
            height: 25.0,
            child: ElevatedButton(
                onPressed: () {
                  // logOut(context);
                  final qrAttendListProvider =
                      Provider.of<AttendProvider>(context, listen: true);
                  print(qrAttendListProvider.qrAttendList);
                },
                child: Text("로그아웃",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              lectureDetail.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      width: 200.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: Color(int.parse(
                            '0xFF${lectureDetail['color'].substring(1)}')),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lectureDetail['lectureName'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text("현재 진행 중인 강의가 없습니다."),
              if (attendProvider.classQr)
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: QrImageView(
                          data: jsonEncode(qrData),
                          size: 400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ClassTimer(),
                      ),
                      Text('어플의 카메라를 이용해서 QR을 스캔해 주세요.',
                          style: TextStyle(
                            color: Color(0xff565656),
                            fontSize: 28.0,
                            fontWeight: FontWeight.normal,
                          ))
                    ],
                  ),
                ),
              if (!attendProvider.classQr)
                SizedBox(
                  height: 400.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: lectureStatsList.length,
                          itemBuilder: (context, index) {
                            TextStyle myTextStyle = TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0);

                            ButtonStyle myBtnStyle = ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 50),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                            );

                            String name =
                                lectureStatsList[index]['studentName'];

                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 150.0,
                                        height: 52.0,
                                        decoration: BoxDecoration(
                                            color: Color(0xffeaeaea),
                                            border: Border.all(
                                              color: Color(0xffeaeaea),
                                            )),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              name,
                                              style: TextStyle(
                                                color: Color(0xff565656),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color(0xffeaeaea)),
                                                  // 위쪽 테두리
                                                  right: BorderSide(
                                                      width: 1,
                                                      color: Color(0xffeaeaea)),
                                                  // 오른쪽 테두리
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: Color(
                                                          0xffeaeaea)), // 아래쪽 테두리
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (attendList.contains(
                                                        lectureStatsList[
                                                            index])) {
                                                      return;
                                                    }
                                                    setState(() {
                                                      lectureStatsList[index]
                                                          ['state'] = '출석';
                                                    });
                                                  },
                                                  style: myBtnStyle.copyWith(
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                                Color>(
                                                            Color(lectureStatsList[
                                                                            index]
                                                                        [
                                                                        'state'] ==
                                                                    '출석'
                                                                ? 0xff8fbe61
                                                                : 0xffffffff)),
                                                  ),
                                                  child: Text(
                                                    "출석",
                                                    style: myTextStyle.copyWith(
                                                        color: lectureStatsList[
                                                                        index]
                                                                    ['state'] ==
                                                                '출석'
                                                            ? Colors.white
                                                            : Color(
                                                                0xff565656)),
                                                  )),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color(0xffeaeaea)),
                                                  // 위쪽 테두리
                                                  right: BorderSide(
                                                      width: 1,
                                                      color: Color(0xffeaeaea)),
                                                  // 오른쪽 테두리
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: Color(
                                                          0xffeaeaea)), // 아래쪽 테두리
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (attendList.contains(
                                                        lectureStatsList[
                                                            index])) {
                                                      return;
                                                    }
                                                    setState(() {
                                                      lectureStatsList[index]
                                                          ['state'] = '결석';
                                                    });
                                                  },
                                                  style: myBtnStyle.copyWith(
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                                Color>(
                                                            Color((lectureStatsList[
                                                                            index]
                                                                        [
                                                                        'state'] ==
                                                                    '결석'
                                                                ? 0xffda7e7e
                                                                : 0xffffffff))),
                                                  ),
                                                  child: Text(
                                                    "결석",
                                                    style: myTextStyle.copyWith(
                                                        color: lectureStatsList[
                                                                        index]
                                                                    ['state'] ==
                                                                '결석'
                                                            ? Colors.white
                                                            : Color(
                                                                0xff565656)),
                                                  )),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color(0xffeaeaea)),
                                                  // 위쪽 테두리
                                                  right: BorderSide(
                                                      width: 1,
                                                      color: Color(0xffeaeaea)),
                                                  // 오른쪽 테두리
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: Color(
                                                          0xffeaeaea)), // 아래쪽 테두리
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (attendList.contains(
                                                        lectureStatsList[
                                                            index])) {
                                                      return;
                                                    }
                                                    setState(() {
                                                      lectureStatsList[index]
                                                          ['state'] = '지각';
                                                    });
                                                  },
                                                  style: myBtnStyle.copyWith(
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                                Color>(
                                                            Color(lectureStatsList[
                                                                            index]
                                                                        [
                                                                        'state'] ==
                                                                    '지각'
                                                                ? 0xfff3d97c
                                                                : 0xffffffff)),
                                                  ),
                                                  child: Text(
                                                    "지각",
                                                    style: myTextStyle.copyWith(
                                                        color: lectureStatsList[
                                                                        index]
                                                                    ['state'] ==
                                                                '지각'
                                                            ? Colors.white
                                                            : Color(
                                                                0xff565656)),
                                                  )),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color(0xffeaeaea)),
                                                  // 위쪽 테두리
                                                  right: BorderSide(
                                                      width: 1,
                                                      color: Color(0xffeaeaea)),
                                                  // 오른쪽 테두리
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: Color(
                                                          0xffeaeaea)), // 아래쪽 테두리
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (attendList.contains(
                                                        lectureStatsList[
                                                            index])) {
                                                      return;
                                                    }
                                                    setState(() {
                                                      lectureStatsList[index]
                                                          ['state'] = '보류';
                                                    });
                                                  },
                                                  style: myBtnStyle.copyWith(
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                                Color>(
                                                            Color(lectureStatsList[
                                                                            index]
                                                                        [
                                                                        'state'] ==
                                                                    '보류'
                                                                ? 0xffcccccc
                                                                : 0xffffffff)),
                                                  ),
                                                  child: Text(
                                                    "보류",
                                                    style: myTextStyle.copyWith(
                                                        color: lectureStatsList[
                                                                        index]
                                                                    ['state'] ==
                                                                '보류'
                                                            ? Colors.white
                                                            : Color(
                                                                0xff565656)),
                                                  )),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            );
                          })),
                    ],
                  ),
                ),
              if (lectureDetail.isNotEmpty &&
                  attendList.isEmpty &&
                  !attendProvider.classQr)
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  width: 100.0,
                  height: 40.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    onPressed: () {
                      createAttend();
                    },
                    child: Text('제출',
                        style: TextStyle(
                          fontSize: 20.0,
                        )),
                  ),
                ),
              if (lectureDetail.isNotEmpty &&
                  attendList.isNotEmpty &&
                  !attendProvider.classQr)
                Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Text(
                      '이미 출석 체크가 완료된 과목입니다.',
                    ))
            ],
          ),
        ],
      ));
    });
  }
}

class ClassTimer extends StatefulWidget {
  const ClassTimer({Key? key}) : super(key: key);

  @override
  State<ClassTimer> createState() => ClassTimerState();
}

class ClassTimerState extends State<ClassTimer> {
  static const int _maxSeconds = 10;
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
          Provider.of<AttendProvider>(context, listen: false).setFalseQr();
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
            color: Color(0xff565656),
            fontSize: 48.0,
          )),
    );
  }
}
