import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_setup.dart';

class ClassMain extends StatefulWidget {
  const ClassMain({Key? key}) : super(key: key);

  @override
  State<ClassMain> createState() => ClassMainState();
}

class ClassMainState extends State<ClassMain> {
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
    await getAttendList();
    print(attendList);

    if (attendList != null) {
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

        for (int i = 0; i < lectureStatsList.length; i++) {
          lectureStatsList[i]['studentName'] = lectureStatsList[i]['name'];
          lectureStatsList[i]['state'] = '';
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
    if (lectureDetail != null) {
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
    print(result);

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
    }
  }

  @override
  void initState() {
    getLectureList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        lectureDetail.isNotEmpty
            ? Container(
                width: 150.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  color: Color(
                      int.parse('0xFF${lectureDetail['color'].substring(1)}')),
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
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: lectureStatsList.length,
            itemBuilder: (context, index) {
              TextStyle myTextStyle =
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);

              ButtonStyle myBtnStyle = ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
              );

              String name = lectureStatsList[index]['studentName'];

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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 위쪽 테두리
                                    right: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 오른쪽 테두리
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 아래쪽 테두리
                                  ),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (attendList
                                          .contains(lectureStatsList[index])) {
                                        return;
                                      }
                                      setState(() {
                                        lectureStatsList[index]['state'] = '출석';
                                      });
                                    },
                                    style: myBtnStyle.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(lectureStatsList[index]
                                                          ['state'] ==
                                                      '출석'
                                                  ? 0xff8fbe61
                                                  : 0xffffffff)),
                                    ),
                                    child: Text(
                                      "출석",
                                      style: myTextStyle.copyWith(
                                          color: lectureStatsList[index]
                                                      ['state'] ==
                                                  '출석'
                                              ? Colors.white
                                              : Color(0xff565656)),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 위쪽 테두리
                                    right: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 오른쪽 테두리
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 아래쪽 테두리
                                  ),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (attendList
                                          .contains(lectureStatsList[index])) {
                                        return;
                                      }
                                      setState(() {
                                        lectureStatsList[index]['state'] = '결석';
                                      });
                                    },
                                    style: myBtnStyle.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color((lectureStatsList[index]
                                                          ['state'] ==
                                                      '결석'
                                                  ? 0xffda7e7e
                                                  : 0xffffffff))),
                                    ),
                                    child: Text(
                                      "결석",
                                      style: myTextStyle.copyWith(
                                          color: lectureStatsList[index]
                                                      ['state'] ==
                                                  '결석'
                                              ? Colors.white
                                              : Color(0xff565656)),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 위쪽 테두리
                                    right: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 오른쪽 테두리
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 아래쪽 테두리
                                  ),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (attendList
                                          .contains(lectureStatsList[index])) {
                                        return;
                                      }
                                      setState(() {
                                        lectureStatsList[index]['state'] = '지각';
                                      });
                                    },
                                    style: myBtnStyle.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(lectureStatsList[index]
                                                          ['state'] ==
                                                      '지각'
                                                  ? 0xfff3d97c
                                                  : 0xffffffff)),
                                    ),
                                    child: Text(
                                      "지각",
                                      style: myTextStyle.copyWith(
                                          color: lectureStatsList[index]
                                                      ['state'] ==
                                                  '지각'
                                              ? Colors.white
                                              : Color(0xff565656)),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 위쪽 테두리
                                    right: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 오른쪽 테두리
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Color(0xffeaeaea)), // 아래쪽 테두리
                                  ),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (attendList
                                          .contains(lectureStatsList[index])) {
                                        return;
                                      }
                                      setState(() {
                                        lectureStatsList[index]['state'] = '보류';
                                      });
                                    },
                                    style: myBtnStyle.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(lectureStatsList[index]
                                                          ['state'] ==
                                                      '보류'
                                                  ? 0xffcccccc
                                                  : 0xffffffff)),
                                    ),
                                    child: Text(
                                      "보류",
                                      style: myTextStyle.copyWith(
                                          color: lectureStatsList[index]
                                                      ['state'] ==
                                                  '보류'
                                              ? Colors.white
                                              : Color(0xff565656)),
                                    )),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              );
            }),
        if (attendList == null)
          ElevatedButton(
            onPressed: () {
              createAttend();
            },
            child: Text('제출'),
          ),
        if (attendList != null) Text('이미 출석 체크가 완료된 과목입니다.')
      ],
    ));
  }
}
