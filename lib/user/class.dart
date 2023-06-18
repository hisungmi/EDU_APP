import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edu_application_pre/user/attendance_status.dart';
import 'package:edu_application_pre/user/exam.dart';
import 'package:edu_application_pre/user/assignment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../http_setup.dart';

class Class extends StatefulWidget {
  final String pageIndex;

  const Class({Key? key, required this.pageIndex}) : super(key: key);
  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  bool isAfternoon = true;
  static List<dynamic> morningDataList = [];
  static List<dynamic> afternoonDataList = [];
  Map<int, dynamic> day = {
    1: '월요일',
    2: '화요일',
    3: '수요일',
    4: '목요일',
    5: '금요일',
    6: '토요일',
    7: '일요일',
  };

  String getDay(int dayNumber) {
    return day[dayNumber];
  }

  String studentKey = '';
  Future<void> loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      Map<String, dynamic> dataMap = jsonDecode(userData);
      setState(() {
        studentKey = dataMap['studentKey'] ?? '';
      });
    }
    // await getLectureList(studentKey);
  }

  Future<void> getLectureList() async {
    Map<String, dynamic> data = {
      'userKey': '',
      'roomKey': '',
      'roomName': '',
      'lectureName': '',
      'target': '',
    };
    afternoonDataList = [];
    morningDataList = [];
    var res = await post('/lectures/getLectureList/', jsonEncode(data));
    // mounted 속성을 확인하여 현재 위젯이 여전히 트리에 존재하는지 확인
    if (mounted) {
      setState(() {
        if (res.statusCode == 200) {
          List<dynamic> lecture = res.data['resultData']
              .where((lecture) =>
                  lecture['progress'] == '등록' &&
                  lecture['startTime'].isNotEmpty)
              .toList();
          for (var i in lecture) {
            int startTime = int.parse(i['startTime'].substring(0, 2));
            if (startTime >= 13) {
              afternoonDataList = lecture;
            } else {
              morningDataList = lecture;
            }
          }
        }
      });
    }
  }

  //비동기 작업의 수행을 취소하거나 중단하기 전에 dispose() 메서드에서 적절한 정리 작업을 수행
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {
      getLectureList();
    });
  }

  //강의 데이터 변수
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 379,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isAfternoon
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  isAfternoon = false;
                                });
                              },
                              child: Container(
                                width: 65.57,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(12),
                                    ),
                                    border: Border.all(
                                      color: Color(0xff9c9c9c),
                                    )),
                                child: Center(
                                    child: Text(
                                  "오전",
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            )
                          : Container(
                              width: 65.57,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xff0099ee),
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color: Color(0xff0099ee),
                                  )),
                              child: Center(
                                child: Text(
                                  "오전",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                      isAfternoon
                          ? Container(
                              width: 65.57,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xff0099ee),
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color: Color(0xff0099ee),
                                  )),
                              child: Center(
                                child: Text(
                                  "오후",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isAfternoon = true;
                                });
                              },
                              child: Container(
                                width: 65.57,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(12),
                                    ),
                                    border: Border.all(
                                      color: Color(0xff9c9c9c),
                                    )),
                                child: Center(
                                    child: Text(
                                  "오후",
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //index 값으로 리스트 표현할때
                if (isAfternoon)
                  afternoonDataList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: afternoonDataList.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> lectureList =
                                  afternoonDataList[index];
                              //컬러타입변환 inp.parse(), 16진수로 표현된 색상코드를 읽어와 알파값을 255로 설정한 color객체 생성
                              // 16진수를 10진수 정수형으로 변환과정  '0xff000000' 은 color에 알파값은 필수, 알파값 = 투명도, 알파값을 255로 설정한 것
                              //문자열에서 첫번쨰 문자 #을 제거한 나머지 문자열로 색상코드앞에 0xFF를 붙인것 16진수 색상코드 만들기
                              Color color = Colors.black;
                              String? colorValue = lectureList['color'];
                              if (colorValue != null && colorValue.isNotEmpty) {
                                color = Color(int.parse(
                                    '0xFF${lectureList['color'].substring(1)}'));
                              }
                              String getday = getDay(lectureList['day']);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAfternoon = true;
                                  });
                                  //흑흑 중요한점!!! 배열의 길이가 다른경우 길이가 작은쪽에 맞추어 반복문을 실행한다.... 하 시방몰랐자나...
                                  //true 값을 보내니까 morning 데이터도 lectureList로 보내자.
                                  if (widget.pageIndex == 'attendance') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AttendanceStatus(
                                                    isAfternoon: isAfternoon,
                                                    morning: lectureList,
                                                    afternoon: lectureList)));
                                  } else if (widget.pageIndex == 'exam') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Exam(
                                                isAfternoon: isAfternoon,
                                                morning: lectureList,
                                                afternoon: lectureList)));
                                  } else if (widget.pageIndex == 'assignment') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Assignment(
                                                isAfternoon: isAfternoon,
                                                morning: lectureList,
                                                afternoon: lectureList)));
                                  }
                                },
                                child: Container(
                                  width: 379,
                                  height: 71,
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                                  padding:
                                      EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 50,
                                        child: Text(
                                          getday,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Center(
                                        child: Container(
                                          width: 115,
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            lectureList['lectureName'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Container(
                                        width: 73,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '강의실|',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        lectureList['roomName'],
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '강사명|',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: lectureList[
                                                        'teacherName'],
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: Text('강의 정보가 없습니다.',
                                style: TextStyle(color: Color(0xffb7b7b7))),
                          ),
                        )
                else
                  morningDataList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: morningDataList.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> lectureList =
                                  morningDataList[index];
                              //컬러타입변환 inp.parse()
                              Color color = Colors.black;
                              String? colorValue = lectureList['color'];
                              if (colorValue != null && colorValue.isNotEmpty) {
                                color = Color(int.parse(
                                    '0xFF${lectureList['color'].substring(1)}'));
                              }

                              String getday = getDay(lectureList['day']);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAfternoon = false;
                                  });
                                  if (widget.pageIndex == 'attendance') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AttendanceStatus(
                                                    isAfternoon: isAfternoon,
                                                    morning: lectureList,
                                                    afternoon: lectureList)));
                                  } else if (widget.pageIndex == 'exam') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Exam(
                                                isAfternoon: isAfternoon,
                                                morning: lectureList,
                                                afternoon: lectureList)));
                                  } else if (widget.pageIndex == 'assignment') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Assignment(
                                                isAfternoon: isAfternoon,
                                                morning: lectureList,
                                                afternoon: lectureList)));
                                  }
                                },
                                child: Container(
                                  width: 358,
                                  height: 71,
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                                  padding:
                                      EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 110,
                                        child: Text(
                                          getday,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        width: 115,
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          lectureList['lectureName'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          minFontSize: 14,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Container(
                                        width: 73,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '강의실|',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        lectureList['roomName'],
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '강사명|',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: lectureList[
                                                        'teacherName'],
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: Text('강의 정보가 없습니다.',
                                style: TextStyle(color: Color(0xffb7b7b7))),
                          ),
                        )
              ],
            )));
  }
}
